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


    public init(width widthBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat, height heightBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat) {
        self.builderBundle = BuilderBundle(itemSizeDescription: .widthAndHeight(widthBuilder: widthBuilder, heightBuilder: heightBuilder))
        super.init()
    }


    public convenience init(width: CGFloat, height heightBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat) {
        self.init(width: { _ in width }, height: heightBuilder)
    }


    public convenience init(width widthBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat, height: CGFloat) {
        self.init(width: widthBuilder, height: { _ in height })
    }


    public convenience init(width : CGFloat, height: CGFloat) {
        self.init(width: width, height: { _ in height })
    }


    public init(height heightBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat, aspectRatio aspectRatioBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat) {
        self.builderBundle = BuilderBundle(itemSizeDescription: .heightAndAspectRatio(heightBuilder: heightBuilder, aspectRatioBuilder: aspectRatioBuilder))
        super.init()
    }


    public convenience init(height: CGFloat, aspectRatio aspectRatioBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat) {
        self.init(height: { _ in height }, aspectRatio: aspectRatioBuilder)
    }


    public convenience init(height heightBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat, aspectRatio: CGFloat) {
        self.init(height: heightBuilder, aspectRatio: { _ in aspectRatio })
    }


    public convenience init(height: CGFloat, aspectRatio: CGFloat) {
        self.init(height: height, aspectRatio: { _ in aspectRatio })
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

    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat, height heightBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat) -> TopLeftLayout {
        self.builderBundle.itemSizeDescription = .widthAndHeight(widthBuilder: widthBuilder, heightBuilder: heightBuilder)
        return self
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, height heightBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat) -> TopLeftLayout {
        return self.setItemSize(withWidth: { _ in width }, height: heightBuilder)
    }


    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat, height: CGFloat) -> TopLeftLayout {
        return self.setItemSize(withWidth: widthBuilder, height: { _ in height })
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, height: CGFloat) -> TopLeftLayout {
        return self.setItemSize(withWidth: width, height: { _ in height })
    }


    @discardableResult
    open func setItemSize(withHeight heightBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat, aspectRatio aspectRatioBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat) -> TopLeftLayout {
        self.builderBundle.itemSizeDescription = .heightAndAspectRatio(heightBuilder: heightBuilder, aspectRatioBuilder: aspectRatioBuilder)
        return self
    }


    @discardableResult
    open func setItemSize(withHeight height: CGFloat, aspectRatio aspectRatioBuilder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat) -> TopLeftLayout {
        return self.setItemSize(withHeight: { _ in height }, aspectRatio: aspectRatioBuilder)
    }


    @discardableResult
    open func setItemSize(withHeight heightBuilder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGFloat, aspectRatio: CGFloat) -> TopLeftLayout {
        return self.setItemSize(withHeight: heightBuilder, aspectRatio: { _ in aspectRatio })
    }


    @discardableResult
    open func setItemSize(withHeight height: CGFloat, aspectRatio: CGFloat) -> TopLeftLayout {
        return self.setItemSize(withHeight: height, aspectRatio: { _ in aspectRatio })
    }


    @discardableResult
    open func setContentAlignment(_ builder: @escaping (TopLeftLayoutSectionBasedParameter) -> ContentAlignment) -> TopLeftLayout {
        self.builderBundle.contentAlignmentBuilder = builder
        return self
    }


    @discardableResult
    open func setContentAlignment(_ alignment: ContentAlignment) -> TopLeftLayout {
        return self.setContentAlignment { _ in alignment }
    }


    @discardableResult
    open func setItemSpacing(_ builder: @escaping (TopLeftLayoutSectionBasedParameter) -> CGSize) -> TopLeftLayout {
        self.builderBundle.itemSpacingBuilder = builder
        return self
    }


    @discardableResult
    open func setItemSpacing(_ spacing: CGSize) -> TopLeftLayout {
        return self.setItemSpacing { _ in spacing }
    }


    @discardableResult
    open func setItemSpacing(width: CGFloat, height: CGFloat) -> TopLeftLayout {
        return self.setItemSpacing(CGSize(width: width, height: height))
    }


    @discardableResult
    open func setSectionInsets(_ builder: @escaping (TopLeftLayoutSectionBasedParameter) -> UIEdgeInsets) -> TopLeftLayout {
        self.builderBundle.sectionInsetsBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionInsets(_ insets: UIEdgeInsets) -> TopLeftLayout {
        return self.setSectionInsets { _ in insets }
    }


    @discardableResult
    open func setSectionInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> TopLeftLayout {
        return self.setSectionInsets(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }


    @discardableResult
    open func setNumberOfSectionHeader(_ builder: @escaping (TopLeftLayoutSectionBasedParameter) -> Int) -> TopLeftLayout {
        self.builderBundle.numberOfSectionHeadersBuilder = builder
        return self
    }


    @discardableResult
    open func setNumberOfSectionHeader(_ number: Int) -> TopLeftLayout {
        return self.setNumberOfSectionHeader { _ in number }
    }


    @discardableResult
    open func setSectionHeaderHeight(_ builder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat) -> TopLeftLayout {
        self.builderBundle.sectionHeaderHeightBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionHeaderHeight(_ height: CGFloat) -> TopLeftLayout {
        return self.setSectionHeaderHeight { _ in height }
    }


    @discardableResult
    open func setSectionHeaderInsets(_ builder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> UIEdgeInsets) -> TopLeftLayout {
        self.builderBundle.sectionHeaderInsetsBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionHeaderInsets(_ insets: UIEdgeInsets) -> TopLeftLayout {
        return self.setSectionHeaderInsets { _ in insets }
    }


    @discardableResult
    open func setSectionHeaderInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> TopLeftLayout {
        return self.setSectionHeaderInsets(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }


    @discardableResult
    open func setNumberOfSectionFooter(_ builder: @escaping (TopLeftLayoutSectionBasedParameter) -> Int) -> TopLeftLayout {
        self.builderBundle.numberOfSectionFootersBuilder = builder
        return self
    }


    @discardableResult
    open func setNumberOfSectionFooter(_ number: Int) -> TopLeftLayout {
        return self.setNumberOfSectionFooter { _ in number }
    }


    @discardableResult
    open func setSectionFooterHeight(_ builder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> CGFloat) -> TopLeftLayout {
        self.builderBundle.sectionFooterHeightBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionFooterHeight(_ height: CGFloat) -> TopLeftLayout {
        return self.setSectionFooterHeight { _ in height }
    }


    @discardableResult
    open func setSectionFooterInsets(_ builder: @escaping (TopLeftLayoutIndexPathBasedParameter) -> UIEdgeInsets) -> TopLeftLayout {
        self.builderBundle.sectionFooterInsetsBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionFooterInsets(_ insets: UIEdgeInsets) -> TopLeftLayout {
        return self.setSectionFooterInsets { _ in insets }
    }


    @discardableResult
    open func setSectionFooterInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> TopLeftLayout {
        return self.setSectionFooterInsets(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

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
        var attributesInSection: [[UICollectionViewLayoutAttributes]] = []
        var lineNumber = 0

        for item in 0 ..< collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(item: item, section: section)
            let itemWidth = self.builderBundle.itemWidth(of: collectionView, layout: self, forItemAt: indexPath)

            var frame = attributesInLine.last?.frame ?? .zero

            if frame == .zero {
                frame.origin.x = sectionInsets.left
            } else if frame.maxX + itemSpacing.width + itemWidth < self.contentWidth - sectionInsets.right {
                frame.origin.x = frame.maxX + itemSpacing.width
            } else {
                frame.origin.x = sectionInsets.left

                cellMinY += itemHeight + itemSpacing.height
                attributesInSection.append(self.leftInsetAdjustedAttributes(attributesInLine, with: sectionInsets.right, alignment: contentAlignment))
                attributesInLine = []
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

        if attributesInLine.count > 0 {
            attributesInSection.append(self.leftInsetAdjustedAttributes(attributesInLine, with: sectionInsets.right, alignment: contentAlignment))
        }

        self.cellAttributes.append(attributesInSection.reduce([]) { $0 + $1 })
    }


    private func leftInsetAdjustedAttributes(_ source: [UICollectionViewLayoutAttributes], with sectionRightInset: CGFloat, alignment: ContentAlignment) -> [UICollectionViewLayoutAttributes] {
        let additionalInset = self.contentWidth - sectionRightInset - (source.last?.frame.maxX ?? 0)

        guard additionalInset > 0 else {
            return source
        }

        switch alignment {
        case .left:
            break

        case .right:
            for attributes in source {
                attributes.frame.origin.x += additionalInset
            }

        case .center:
            for attributes in source {
                attributes.frame.origin.x += additionalInset / 2
            }
        }

        return source
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
