//
// Created by Alan on 2019-07-10.
// Copyright (c) 2019 Frog Lab. All rights reserved.
//


import Foundation
import UIKit


open class TopLeftLayout: DecorationViewSupportableLayout {

    fileprivate var cellAttributes: [[UICollectionViewLayoutAttributes]] = []
    fileprivate var sectionHeaderAttributes: [[UICollectionViewLayoutAttributes]] = []
    fileprivate var sectionFooterAttributes: [[UICollectionViewLayoutAttributes]] = []

    fileprivate var builderBundle: BuilderBundle


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


    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


public typealias TopLeftLayoutSectionBasedParameter = (collectionView: UICollectionView, layout: TopLeftLayout, section: Int)
public typealias TopLeftLayoutIndexPathBasedParameter = (collectionView: UICollectionView, layout: TopLeftLayout, indexPath: IndexPath)


extension TopLeftLayout {

    public enum ContentAlignment {

        case left
        case right
        case center

    }

}


extension TopLeftLayout {

//    @discardableResult
//    open func setItemSize(withWidth widthBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat, height heightBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> ContentAlignment) -> TopLeftLayout {
//        self.builderBundle.itemSizeDescription = .sizeWithAlignment(widthBuilder: widthBuilder, heightBuilder: heightBuilder, alignmentBuilder: alignmentBuilder)
//        return self
//    }

}


extension TopLeftLayout {

    open override func invalidateLayout() {
        super.invalidateLayout()

        self.cellAttributes = []
        self.sectionHeaderAttributes = []
        self.sectionFooterAttributes = []

        self.contentHeight = 0
    }

}


extension TopLeftLayout {

    open override func prepare() {
        super.prepare()

        guard self.cellAttributes.isEmpty,
              let collectionView = self.collectionView else {
            return
        }

        self.contentHeight = self.topSpaceForDecorationView

        for section in 0 ..< collectionView.numberOfSections {
            let sectionInsets = self.builderBundle.sectionInsetsBuilder((collectionView, layout: self, section))

            self.prepareSectionHeaders(of: collectionView, with: sectionInsets, forSectionAt: section)
            self.prepareCells(of: collectionView, with: sectionInsets, forSectionAt: section)
            self.prepareSectionFooters(of: collectionView, with: sectionInsets, forSectionAt: section)
        }

        self.contentHeight += self.bottomSpaceForDecorationView
    }


    private func prepareSectionHeaders(of collectionView: UICollectionView, with sectionInsets: UIEdgeInsets, forSectionAt section: Int) {
        self.contentHeight = self.contentHeight + sectionInsets.top

        var sectionHeaderCount = self.builderBundle.numberOfSectionHeadersBuilder((collectionView, layout: self, section))

        if sectionHeaderCount < 1,
           self.builderBundle.sectionHeaderHeightBuilder((collectionView, layout: self, IndexPath(item: 0, section: section))) > 0 {
            sectionHeaderCount = 1
        }

        var sectionHeaderAttributesInSection: [UICollectionViewLayoutAttributes] = []
        var previousBottomInset: CGFloat = 0

        for index in 0 ..< sectionHeaderCount {
            let indexPath = IndexPath(item: index, section: section)
            let height = self.builderBundle.sectionHeaderHeightBuilder((collectionView, layout: self, indexPath))
            let insets = self.builderBundle.sectionHeaderInsetsBuilder((collectionView, layout: self, indexPath))

            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
            attributes.frame = CGRect(
                    x: sectionInsets.left + insets.left,
                    y: self.contentHeight + previousBottomInset + insets.top,
                    width: self.contentWidth - sectionInsets.left - sectionInsets.right - insets.left - insets.right,
                    height: height
            )
            sectionHeaderAttributesInSection.append(attributes)

            previousBottomInset = insets.bottom
            self.contentHeight = attributes.frame.maxY
        }

        self.sectionHeaderAttributes.append(sectionHeaderAttributesInSection)
        self.contentHeight += previousBottomInset
    }


    private func prepareCells(of collectionView: UICollectionView, with sectionInsets: UIEdgeInsets, forSectionAt section: Int) {
        let itemHeight = self.builderBundle.itemHeight(of: collectionView, layout: self, forSectionAt: section)
        let itemSpacing = self.builderBundle.itemSpacingBuilder((collectionView, layout: self, section))
        let contentAlignment = self.builderBundle.contentAlignmentBuilder((collectionView, layout: self, section))
        let sectionInsets = self.builderBundle.sectionInsetsBuilder((collectionView, layout: self, section))

        var cellMinY = self.contentHeight
        var attributesInLine: [UICollectionViewLayoutAttributes] = []
        var attributesInSection: [[UICollectionViewLayoutAttributes]] = [attributesInLine]
        var lineNumber = 0

        for item in 0 ..< collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(item: item, section: section)
            let itemWidth = self.builderBundle.itemWidth(of: collectionView, layout: self, forItemAt: indexPath)

            var frame = attributesInLine.last?.frame ?? .zero

            if frame == .zero {
                frame.origin.x = collectionView.contentInset.left + sectionInsets.left
            } else if frame.maxX + itemSpacing.width + itemWidth < collectionView.contentInset.left + self.contentWidth - sectionInsets.right {
                frame.origin.x = frame.maxX + itemSpacing.width
            } else {
                frame.origin.x = collectionView.contentInset.left + sectionInsets.left

                let additionalInset = self.contentWidth - sectionInsets.right - ((attributesInLine.last?.frame.maxX ?? 0) - collectionView.contentInset.left)

                if additionalInset > 0 {
                    switch contentAlignment {
                    case .left:
                        break

                    case .right:
                        for attributes in attributesInLine {
                            attributes.frame.origin.x += additionalInset
                        }

                    case .center:
                        for attributes in attributesInLine {
                            attributes.frame.origin.x += additionalInset / 2
                        }
                    }
                }

                cellMinY += itemHeight + itemSpacing.height
                attributesInLine = []
                attributesInSection.append(attributesInLine)
                lineNumber += 1
            }

            frame.origin.y = cellMinY
            frame.size.width = itemWidth
            frame.size.height = itemHeight

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            attributesInLine.append(attributes)

            if frame.maxY > self.contentHeight {
                self.contentHeight = frame.maxY
            }
        }

        self.cellAttributes.append(attributesInSection.reduce([]) { $0 + $1 })
    }


    private func prepareSectionFooters(of collectionView: UICollectionView, with sectionInsets: UIEdgeInsets, forSectionAt section: Int) {
        var sectionFooterCount = self.builderBundle.numberOfSectionFootersBuilder((collectionView, layout: self, section))

        if sectionFooterCount < 1,
           self.builderBundle.sectionFooterHeightBuilder((collectionView, layout: self, IndexPath(item: 0, section: section))) > 0 {
            sectionFooterCount = 1
        }

        var sectionFooterAttributesInSection: [UICollectionViewLayoutAttributes] = []
        var previousBottomInset: CGFloat = 0

        for index in 0 ..< sectionFooterCount {
            let indexPath = IndexPath(item: index, section: section)
            let height = self.builderBundle.sectionFooterHeightBuilder((collectionView, layout: self, indexPath))
            let insets = self.builderBundle.sectionFooterInsetsBuilder((collectionView, layout: self, indexPath))

            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: indexPath)
            attributes.frame = CGRect(
                    x: sectionInsets.left + insets.left,
                    y: self.contentHeight + previousBottomInset + insets.top,
                    width: self.contentWidth - sectionInsets.left - sectionInsets.right - insets.left - insets.right,
                    height: height
            )
            sectionFooterAttributesInSection.append(attributes)

            previousBottomInset = insets.bottom
            self.contentHeight = attributes.frame.maxY
        }

        self.sectionFooterAttributes.append(sectionFooterAttributesInSection)
        self.contentHeight += previousBottomInset + sectionInsets.bottom
    }


    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect = super.layoutAttributesForElements(in: rect) ?? []

        let allAttributes = Array(self.cellAttributes.joined())
                + Array(self.sectionHeaderAttributes.joined())
                + Array(self.sectionFooterAttributes.joined())

        for attributes in allAttributes {
            guard attributes.frame.intersects(rect) else {
                continue
            }

            attributesInRect.append(attributes)
        }

        return attributesInRect
    }


    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cellAttributes[indexPath.section][indexPath.row]
    }


    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return self.sectionHeaderAttributes[indexPath.section][indexPath.row]

        case UICollectionView.elementKindSectionFooter:
            return self.sectionFooterAttributes[indexPath.section][indexPath.row]

        default:
            return nil
        }
    }

}


extension TopLeftLayout {

    fileprivate enum ItemSizeDescription {

        case widthAndHeight(widthBuilder: (TopLeftLayoutIndexPathBasedParameter) -> CGFloat, heightBuilder: (TopLeftLayoutSectionBasedParameter) -> CGFloat)
        case heightAndAspectRatio(heightBuilder: (TopLeftLayoutSectionBasedParameter) -> CGFloat, aspectRatioBuilder: (TopLeftLayoutIndexPathBasedParameter) -> CGFloat)

    }


    fileprivate class BuilderBundle {

        var itemSizeDescription: ItemSizeDescription
        var contentAlignmentBuilder: (TopLeftLayoutSectionBasedParameter) -> ContentAlignment = { _ in .left }

        var itemSpacingBuilder: (TopLeftLayoutSectionBasedParameter) -> CGSize = { _ in .zero }
        var sectionInsetsBuilder: (TopLeftLayoutSectionBasedParameter) -> UIEdgeInsets = { _ in .zero }

        var numberOfSectionHeadersBuilder: (TopLeftLayoutSectionBasedParameter) -> Int = { _ in 0 }
        var sectionHeaderHeightBuilder: (TopLeftLayoutIndexPathBasedParameter) -> CGFloat = { _ in 0 }
        var sectionHeaderInsetsBuilder: (TopLeftLayoutIndexPathBasedParameter) -> UIEdgeInsets = { _ in .zero }

        var numberOfSectionFootersBuilder: (TopLeftLayoutSectionBasedParameter) -> Int = { _ in 0 }
        var sectionFooterHeightBuilder: (TopLeftLayoutIndexPathBasedParameter) -> CGFloat = { _ in 0 }
        var sectionFooterInsetsBuilder: (TopLeftLayoutIndexPathBasedParameter) -> UIEdgeInsets = { _ in .zero }


        init(itemSizeDescription: ItemSizeDescription) {
            self.itemSizeDescription = itemSizeDescription
        }


        func itemWidth(of collectionView: UICollectionView, layout: TopLeftLayout, forItemAt indexPath: IndexPath) -> CGFloat {
            switch self.itemSizeDescription {
            case let .widthAndHeight(widthBuilder, _):
                return max(widthBuilder((collectionView, layout, indexPath)), 0)

            case let .heightAndAspectRatio(heightBuilder, aspectRatioBuilder):
                let height = heightBuilder((collectionView, layout, indexPath.section))
                let aspectRatio = aspectRatioBuilder((collectionView, layout, indexPath))

                guard height > 0,
                      aspectRatio > 0 else {
                    return 0
                }

                return height * aspectRatio
            }
        }


        func itemHeight(of collectionView: UICollectionView, layout: TopLeftLayout, forSectionAt section: Int) -> CGFloat {
            switch self.itemSizeDescription {
            case let .widthAndHeight(_, heightBuilder):
                return max(heightBuilder((collectionView, layout, section)), 0)

            case let .heightAndAspectRatio(heightBuilder, _):
                return max(heightBuilder((collectionView, layout, section)), 0)
            }
        }

    }

}
