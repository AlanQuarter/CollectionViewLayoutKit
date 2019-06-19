//
//  Created by Alan on 13/06/2019.
//  Copyright © 2019 Frog Lab. All rights reserved.
//


import UIKit
import CollectionViewLayoutKit


class ViewController: UIViewController {


    private weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.collectionView = {
            var frame = UIScreen.main.bounds
            frame.origin.y = 64
            frame.size.height -= frame.origin.y

            let layout = WaterfallLayout(
                    itemWidth: { _ in .numberOfColumns(Int.random(in: 2 ... 3)) },
                    itemHeight: { _ in 100 + CGFloat(Int.random(in: 0 ... 100)) })
                    .setItemSpacing(width: 10, height: 10).setSectionInsets { _, _, section in section == 0 ? .zero : UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0) }
                    .setNumberOfSectionHeader(Int.random(in: 1 ... 3))
                    .setSectionHeaderHeight { _ in CGFloat(Int.random(in: 1 ... 2)) * 40 }
                    .setNumberOfSectionFooter(Int.random(in: 1 ... 3))
                    .setSectionHeaderInsets(top: 0, left: 0, bottom: 10, right: 0)
                    .setSectionFooterHeight { _ in CGFloat(Int.random(in: 1 ... 2)) * 40 }
                    .setSectionFooterInsets(top: 10, left: 0, bottom: 0, right: 0)

            let view = UICollectionView(frame: frame, collectionViewLayout: layout)
            view.backgroundColor = .yellow
            view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
            view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
            view.dataSource = self
            view.delegate = self

            self.view.addSubview(view)

            return view
        }()
    }

}


extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let red = Int.random(in: 0 ... 200)
        let green = Int.random(in: 0 ... 200)
        let blue = Int.random(in: 0 ... 200)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor(
                red: CGFloat(red) / 255,
                green: CGFloat(green) / 255,
                blue: CGFloat(blue) / 255,
                alpha: 1
        )

        if let label = cell.contentView.viewWithTag(99) as? UILabel {
            label.frame = cell.bounds
            label.textColor = UIColor(
                    red: CGFloat(255 - red) / 255,
                    green: CGFloat(255 - green) / 255,
                    blue: CGFloat(255 - blue) / 255,
                    alpha: 1
            )
            label.text = "\(indexPath.row)"
        } else {
            let label = UILabel(frame: cell.bounds)
            label.tag = 99
            label.textColor = UIColor(
                    red: CGFloat(255 - red) / 255,
                    green: CGFloat(255 - green) / 255,
                    blue: CGFloat(255 - blue) / 255,
                    alpha: 1
            )
            label.text = "\(indexPath.row)"
            label.textAlignment = .center
            cell.contentView.addSubview(label)
        }

        return cell
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView: UICollectionReusableView

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            sectionHeader.backgroundColor = .red
            supplementaryView = sectionHeader

        case UICollectionView.elementKindSectionFooter:
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            sectionFooter.backgroundColor = .blue
            supplementaryView = sectionFooter

        default:
            supplementaryView = UICollectionReusableView()
        }

        return supplementaryView
    }

}


extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.collectionViewLayout.invalidateLayout()
    }

}
