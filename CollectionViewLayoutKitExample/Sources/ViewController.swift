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
            let layout = WaterfallLayout()
            layout.delegate = self

            let view = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
            view.backgroundColor = self.view.backgroundColor
            view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            view.dataSource = self

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

}


extension ViewController: WaterfallLayoutDelegate {

    func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            horizontalConfigurationForSectionAt section: Int
    ) -> WaterfallLayout.HorizontalConfiguration {
        return WaterfallLayout.HorizontalConfiguration(numberOfWaterfalls: 2)
    }


    func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            heightForItemAt indexPath: IndexPath
    ) -> CGFloat {
        return 100 + CGFloat(Int.random(in: 0 ... 100))
    }


    func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            itemSpacingSizeForSectionAt section: Int
    ) -> CGSize {
        return CGSize(width: 10, height: 10)
    }

}
