//
// Created by Alan on 2019-06-13.
// Copyright (c) 2019 Frog Lab. All rights reserved.
//


import Foundation
import UIKit


open class WaterfallLayout: UICollectionViewLayout {

    private var attributesCache: [[UICollectionViewLayoutAttributes]] = []

    open weak var delegate: WaterfallLayoutDelegate?


    private var contentWidth: CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }

        return collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
    }

    private var contentHeight: CGFloat = 0

    open override var collectionViewContentSize: CGSize {
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }


    open override func prepare() {
        super.prepare()

        guard self.attributesCache.isEmpty,
              let collectionView = self.collectionView,
              let delegate = self.delegate else {
            return
        }

        for section in 0 ..< collectionView.numberOfSections {
            let sectionInsets = delegate.collectionView?(
                    collectionView,
                    layout: self,
                    insetsForSectionAt: section
            ) ?? .zero

            let horizontalLayoutDescription = delegate.collectionView(
                    collectionView,
                    layout: self,
                    horizontalConfigurationForSectionAt: section
            ).layoutDescription

            let itemSpacing = delegate.collectionView?(
                    collectionView,
                    layout: self,
                    itemSpacingSizeForSectionAt: section
            ) ?? .zero

            let contentWidthOfSection = self.contentWidth - sectionInsets.left - sectionInsets.right

            var numberOfColumns = 0
            var cellWidth: CGFloat = 0
            var additionalLeftInset: CGFloat = 0

            switch horizontalLayoutDescription {
            case let .fixedCellWidth(width, alignment):
                let extendedContentWidthOfSection = contentWidthOfSection + itemSpacing.width
                numberOfColumns = Int(extendedContentWidthOfSection / (width + itemSpacing.width))
                cellWidth = width

                switch alignment {
                case .left:
                    break

                case .right:
                    additionalLeftInset = contentWidthOfSection + itemSpacing.width
                            - CGFloat(numberOfColumns) * (cellWidth + itemSpacing.width)

                case .center:
                    additionalLeftInset = (contentWidthOfSection + itemSpacing.width
                            - CGFloat(numberOfColumns) * (cellWidth + itemSpacing.width))
                            / 2
                }

            case let .numberOfWaterfalls(numberOfWaterfalls):
                numberOfColumns = numberOfWaterfalls
                cellWidth = (contentWidthOfSection - CGFloat(numberOfWaterfalls - 1) * itemSpacing.width)
                        / CGFloat(numberOfWaterfalls)
            }

            var contentHeightOfSection: CGFloat = 0
            var attributesInSection: [UICollectionViewLayoutAttributes] = []
            var lastFramesOfColumn: [CGRect] = []

            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                var targetColumnIndex = 0
                var leastMaxY = CGFloat.greatestFiniteMagnitude

                for index in 0 ..< numberOfColumns {
                    guard lastFramesOfColumn.count > index else {
                        lastFramesOfColumn.append(CGRect(
                                x: sectionInsets.left
                                        + additionalLeftInset
                                        + CGFloat(index) * (cellWidth + itemSpacing.width),
                                y: sectionInsets.top - itemSpacing.height,
                                width: cellWidth,
                                height: 0
                        ))
                        targetColumnIndex = index
                        break
                    }

                    let frame = lastFramesOfColumn[index]

                    guard frame.maxY < leastMaxY else {
                        continue
                    }

                    targetColumnIndex = index
                    leastMaxY = frame.maxY
                }

                let indexPath = IndexPath(item: item, section: section)

                var frame = lastFramesOfColumn[targetColumnIndex]
                frame.origin.y += frame.height + itemSpacing.height
                frame.size.height = delegate.collectionView(collectionView, layout: self, heightForItemAt: indexPath)
                lastFramesOfColumn[targetColumnIndex] = frame

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                attributesInSection.append(attributes)

                if frame.maxY > contentHeightOfSection {
                    contentHeightOfSection = frame.maxY
                }
            }

            self.attributesCache.append(attributesInSection)
            self.contentHeight += contentHeightOfSection + sectionInsets.bottom
        }
    }


    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect: [UICollectionViewLayoutAttributes] = []

        for attributesInSection in self.attributesCache {
            for attributes in attributesInSection {
                guard attributes.frame.intersects(rect) else {
                    continue
                }

                attributesInRect.append(attributes)
            }
        }

        return attributesInRect
    }


    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.attributesCache[indexPath.section][indexPath.row]
    }

}


extension WaterfallLayout {

    public class HorizontalConfiguration: NSObject {

        fileprivate let layoutDescription: HorizontalLayoutDescription


        public init(cellWidth: CGFloat, alignment: ContentAlignment = .left) {
            self.layoutDescription = .fixedCellWidth(cellWidth, alignment: alignment)
        }


        public init(numberOfWaterfalls: Int) {
            self.layoutDescription = .numberOfWaterfalls(numberOfWaterfalls)
        }

    }


    public enum ContentAlignment {

        case left
        case right
        case center

    }


    fileprivate enum HorizontalLayoutDescription {

        case fixedCellWidth(CGFloat, alignment: ContentAlignment)
        case numberOfWaterfalls(Int)

    }

}


@objc public protocol WaterfallLayoutDelegate {

    func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            horizontalConfigurationForSectionAt section: Int
    ) -> WaterfallLayout.HorizontalConfiguration

    func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            heightForItemAt indexPath: IndexPath
    ) -> CGFloat

    @objc optional func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            itemSpacingSizeForSectionAt section: Int
    ) -> CGSize

    @objc optional func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            insetsForSectionAt section: Int
    ) -> UIEdgeInsets

    @objc optional func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            referenceSizeForHeaderInSection section: Int
    ) -> CGSize

    @objc optional func collectionView(
            _ collectionView: UICollectionView,
            layout waterfallLayout: WaterfallLayout,
            referenceSizeForFooterInSection section: Int
    ) -> CGSize

}
