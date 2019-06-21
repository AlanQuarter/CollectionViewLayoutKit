//
//  Created by Alan on 13/06/2019.
//  Copyright © 2019 Frog Lab. All rights reserved.
//


import UIKit
import CollectionViewLayoutKit


class WaterfallViewController: UIViewController {

    private let cellIdentifier = "cell"
    private let sectionHeaderIdentifier = "header"
    private let sectionFooterIdentifier = "footer"

    private let cellLabelTag = 17
    private let supplementaryViewLabelTag = 8376


    private weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        let number: Int8 = 0
        let result = CGFloat(number)

        self.collectionView = {
            let layout = WaterfallLayout(height: { _, _, _ in CGFloat(Int.random(in: 100 ... 200)) }, numberOfColumns: 2)
                    .setItemSpacing(width: 10, height: 10)
                    .setSectionInsets { _, _, section in section == 0 ? .zero : UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0) }
                    .setNumberOfSectionHeader { _, _, section in section + 1 }
                    .setSectionHeaderHeight { _ in CGFloat(Int.random(in: 40 ... 100)) }
                    .setSectionHeaderInsets(top: 0, left: 0, bottom: 10, right: 0)
                    .setNumberOfSectionFooter { _, _, section in 2 - section }
                    .setSectionFooterHeight { _ in CGFloat(Int.random(in: 40 ... 100)) }
                    .setSectionFooterInsets(top: 10, left: 0, bottom: 0, right: 0)

            let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
            view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.sectionHeaderIdentifier)
            view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: self.sectionFooterIdentifier)
            view.dataSource = self

            self.view.addSubview(view)

            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
            ])

            return view
        }()
    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.reloadData()
    }

}


extension WaterfallViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(
                red: CGFloat(Int.random(in: 0 ... 255)) / 255,
                green: CGFloat(Int.random(in: 0 ... 255)) / 255,
                blue: CGFloat(Int.random(in: 0 ... 255)) / 255,
                alpha: 0.6
        )

        if let label = cell.contentView.viewWithTag(self.cellLabelTag) as? UILabel {
            label.frame = cell.bounds
            label.text = "\(indexPath.row)"
        } else {
            let label = UILabel(frame: cell.bounds)
            label.tag = self.cellLabelTag
            label.textAlignment = .center
            label.text = "\(indexPath.row)"

            cell.contentView.addSubview(label)
        }

        return cell
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView: UICollectionReusableView
        let identifier: String

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            identifier = self.sectionHeaderIdentifier

            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
            sectionHeader.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            supplementaryView = sectionHeader

        case UICollectionView.elementKindSectionFooter:
            identifier = self.sectionFooterIdentifier

            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
            sectionFooter.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            supplementaryView = sectionFooter

        default:
            identifier = ""
            supplementaryView = UICollectionReusableView()
        }

        if let label = supplementaryView.viewWithTag(self.supplementaryViewLabelTag) as? UILabel {
            label.frame = supplementaryView.bounds
            label.text = identifier
        } else {
            let label = UILabel(frame: supplementaryView.bounds)
            label.tag = self.supplementaryViewLabelTag
            label.textAlignment = .center
            label.text = identifier

            supplementaryView.addSubview(label)
        }

        return supplementaryView
    }

}
