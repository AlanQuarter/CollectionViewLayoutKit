//
// Created by Alan on 2019-06-13.
// Copyright (c) 2019 Frog Lab. All rights reserved.
//


import Foundation
import UIKit


open class WaterfallLayout: UICollectionViewLayout {

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


    public init(itemWidth: @escaping (WaterfallLayoutSectionBasedParameter) -> ItemWidth, itemHeight: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) {
        self.builderBundle = BuilderBundle(itemWidthBuilder: itemWidth, itemHeightBuilder: itemHeight)
        super.init()
    }


    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public convenience init(itemWidth: ItemWidth, itemHeight: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) {
        self.init(itemWidth: { _ in itemWidth }, itemHeight: itemHeight)
    }


    public convenience init(itemWidth: CGFloat, itemHeight: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) {
        self.init(itemWidth: .fixedWidth(itemWidth, alignment: alignment), itemHeight: itemHeight)
    }


    public convenience init(numberOfColumns: Int, itemHeight: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) {
        self.init(itemWidth: .numberOfColumns(numberOfColumns), itemHeight: itemHeight)
    }


    public convenience init(itemWidth: @escaping (WaterfallLayoutSectionBasedParameter) -> ItemWidth, itemHeight: CGFloat) {
        self.init(itemWidth: itemWidth, itemHeight: { _ in itemHeight })
    }


    public convenience init(itemWidth: ItemWidth, itemHeight: CGFloat) {
        self.init(itemWidth: { _ in itemWidth }, itemHeight: itemHeight)
    }


    public convenience init(itemWidth: CGFloat, itemHeight: CGFloat, alignment: ContentAlignment) {
        self.init(itemWidth: .fixedWidth(itemWidth, alignment: alignment), itemHeight: itemHeight)
    }


    public convenience init(numberOfColumns: Int, itemHeight: CGFloat) {
        self.init(itemWidth: .numberOfColumns(numberOfColumns), itemHeight: itemHeight)
    }

}


public typealias WaterfallLayoutParameter = (collectionView: UICollectionView, layout: WaterfallLayout)
public typealias WaterfallLayoutSectionBasedParameter = (collectionView: UICollectionView, layout: WaterfallLayout, section: Int)
public typealias WaterfallLayoutIndexPathBasedParameter = (collectionView: UICollectionView, layout: WaterfallLayout, indexPath: IndexPath)


extension WaterfallLayout {

    public enum ItemWidth {

        case fixedWidth(CGFloat, alignment: ContentAlignment)
        case numberOfColumns(Int)


        fileprivate func width(for contentWidth: CGFloat, sectionInsets: UIEdgeInsets, itemHorizontalSpacing: CGFloat) -> CGFloat {
            switch self {
            case let .fixedWidth(width, _):
                return width

            case let .numberOfColumns(columnCount):
                return (contentWidth - sectionInsets.left - sectionInsets.right - CGFloat(columnCount - 1) * itemHorizontalSpacing) / CGFloat(columnCount)
            }
        }


        fileprivate func columnCount(for contentWidth: CGFloat, sectionInsets: UIEdgeInsets, itemHorizontalSpacing: CGFloat) -> Int {
            switch self {
            case let .fixedWidth(width, _):
                return Int((contentWidth - sectionInsets.left - sectionInsets.right + itemHorizontalSpacing) / (width + itemHorizontalSpacing))

            case let .numberOfColumns(columnCount):
                return columnCount
            }
        }


        fileprivate func additionalLeftInset(for contentWidth: CGFloat, sectionInsets: UIEdgeInsets, itemHorizontalSpacing: CGFloat) -> CGFloat {
            switch self {
            case let .fixedWidth(width, alignment):
                switch alignment {
                case .left:
                    return 0

                case .right:
                    let columnCount = self.columnCount(for: contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemHorizontalSpacing)
                    return contentWidth - sectionInsets.left - sectionInsets.right + itemHorizontalSpacing - CGFloat(columnCount) * (width + itemHorizontalSpacing)

                case .center:
                    return ItemWidth.fixedWidth(width, alignment: .right).additionalLeftInset(for: contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemHorizontalSpacing) / 2
                }

            case .numberOfColumns:
                return 0
            }
        }

    }


    public enum ContentAlignment {

        case left
        case right
        case center

    }

}


extension WaterfallLayout {

    @discardableResult
    open func setItemWidth(_ builder: @escaping (WaterfallLayoutSectionBasedParameter) -> ItemWidth) -> WaterfallLayout {
        self.builderBundle.itemWidthBuilder = builder
        return self
    }


    @discardableResult
    open func setItemWidth(_ itemWidth: ItemWidth) -> WaterfallLayout {
        return self.setItemWidth { _ in itemWidth }
    }


    @discardableResult
    open func setItemWidth(_ width: CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemWidth(.fixedWidth(width, alignment: alignment))
    }


    @discardableResult
    open func setItemWidth(byNumberOfColumns numberOfColumns: Int) -> WaterfallLayout {
        return self.setItemWidth(.numberOfColumns(numberOfColumns))
    }


    @discardableResult
    open func setItemHeight(_ builder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) -> WaterfallLayout {
        self.builderBundle.itemHeightBuilder = builder
        return self
    }


    @discardableResult
    open func setItemHeight(_ height: CGFloat) -> WaterfallLayout {
        return self.setItemHeight { _ in height }
    }


    @discardableResult
    open func setItemSpacing(_ builder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGSize) -> WaterfallLayout {
        self.builderBundle.itemSpacingBuilder = builder
        return self
    }


    @discardableResult
    open func setItemSpacing(_ spacing: CGSize) -> WaterfallLayout {
        return self.setItemSpacing { _ in spacing }
    }


    @discardableResult
    open func setItemSpacing(width: CGFloat, height: CGFloat) -> WaterfallLayout {
        return self.setItemSpacing(CGSize(width: width, height: height))
    }


    @discardableResult
    open func setSectionInsets(_ builder: @escaping (WaterfallLayoutSectionBasedParameter) -> UIEdgeInsets) -> WaterfallLayout {
        self.builderBundle.sectionInsetsBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionInsets(_ insets: UIEdgeInsets) -> WaterfallLayout {
        return self.setSectionInsets { _ in insets }
    }


    @discardableResult
    open func setSectionInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> WaterfallLayout {
        return self.setSectionInsets(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }


    @discardableResult
    open func setNumberOfSectionHeader(_ builder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int) -> WaterfallLayout {
        self.builderBundle.numberOfSectionHeadersBuilder = builder
        return self
    }


    @discardableResult
    open func setNumberOfSectionHeader(_ number: Int) -> WaterfallLayout {
        return self.setNumberOfSectionHeader { _ in number }
    }


    @discardableResult
    open func setSectionHeaderHeight(_ builder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) -> WaterfallLayout {
        self.builderBundle.sectionHeaderHeightBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionHeaderHeight(_ height: CGFloat) -> WaterfallLayout {
        return self.setSectionHeaderHeight { _ in height }
    }


    @discardableResult
    open func setSectionHeaderInsets(_ builder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> UIEdgeInsets) -> WaterfallLayout {
        self.builderBundle.sectionHeaderInsetsBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionHeaderInsets(_ insets: UIEdgeInsets) -> WaterfallLayout {
        return self.setSectionHeaderInsets { _ in insets }
    }


    @discardableResult
    open func setSectionHeaderInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> WaterfallLayout {
        return self.setSectionHeaderInsets(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }


    @discardableResult
    open func setNumberOfSectionFooter(_ builder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int) -> WaterfallLayout {
        self.builderBundle.numberOfSectionFootersBuilder = builder
        return self
    }


    @discardableResult
    open func setNumberOfSectionFooter(_ number: Int) -> WaterfallLayout {
        return self.setNumberOfSectionFooter { _ in number }
    }


    @discardableResult
    open func setSectionFooterHeight(_ builder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) -> WaterfallLayout {
        self.builderBundle.sectionFooterHeightBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionFooterHeight(_ height: CGFloat) -> WaterfallLayout {
        return self.setSectionFooterHeight { _ in height }
    }


    @discardableResult
    open func setSectionFooterInsets(_ builder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> UIEdgeInsets) -> WaterfallLayout {
        self.builderBundle.sectionFooterInsetsBuilder = builder
        return self
    }


    @discardableResult
    open func setSectionFooterInsets(_ insets: UIEdgeInsets) -> WaterfallLayout {
        return self.setSectionFooterInsets { _ in insets }
    }


    @discardableResult
    open func setSectionFooterInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> WaterfallLayout {
        return self.setSectionFooterInsets(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

}


extension WaterfallLayout {

    open override func invalidateLayout() {
        super.invalidateLayout()

        self.cellAttributes = []
        self.sectionHeaderAttributes = []
        self.sectionFooterAttributes = []

        self.contentHeight = 0
    }

}


extension WaterfallLayout {

    open override func prepare() {
        super.prepare()

        guard self.cellAttributes.isEmpty,
              let collectionView = self.collectionView else {
            return
        }

        for section in 0 ..< collectionView.numberOfSections {
            let sectionInsets = self.builderBundle.sectionInsetsBuilder((collectionView, layout: self, section))

            self.prepareSectionHeaders(of: collectionView, with: sectionInsets, forSectionAt: section)
            self.prepareCells(of: collectionView, with: sectionInsets, forSectionAt: section)
            self.prepareSectionFooters(of: collectionView, with: sectionInsets, forSectionAt: section)
        }
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
        let itemWidth = self.builderBundle.itemWidthBuilder((collectionView, layout: self, section))
        let itemSpacing = self.builderBundle.itemSpacingBuilder((collectionView, layout: self, section))

        let width = itemWidth.width(for: self.contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemSpacing.width)
        let columnCount = itemWidth.columnCount(for: self.contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemSpacing.width)
        let additionalLeftInset = itemWidth.additionalLeftInset(for: self.contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemSpacing.width)
        let cellMinY = self.contentHeight

        var attributesInSection: [UICollectionViewLayoutAttributes] = []
        var lastFramesOfColumn: [CGRect] = []

        for item in 0 ..< collectionView.numberOfItems(inSection: section) {
            var targetColumnIndex = 0
            var leastMaxY = CGFloat.greatestFiniteMagnitude

            for index in 0 ..< columnCount {
                guard lastFramesOfColumn.count > index else {
                    let frame = CGRect(
                            x: sectionInsets.left + additionalLeftInset + CGFloat(index) * (width + itemSpacing.width),
                            y: cellMinY - itemSpacing.height,
                            width: width,
                            height: 0
                    )
                    targetColumnIndex = index
                    leastMaxY = frame.maxY

                    lastFramesOfColumn.append(frame)
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
            frame.origin.y = leastMaxY + itemSpacing.height
            frame.size.height = self.builderBundle.itemHeightBuilder((collectionView, layout: self, indexPath))
            lastFramesOfColumn[targetColumnIndex] = frame

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            attributesInSection.append(attributes)

            if frame.maxY > self.contentHeight {
                self.contentHeight = frame.maxY
            }
        }

        self.cellAttributes.append(attributesInSection)
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
        let allAttributes = Array(self.cellAttributes.joined())
                + Array(self.sectionHeaderAttributes.joined())
                + Array(self.sectionFooterAttributes.joined())
        var attributesInRect: [UICollectionViewLayoutAttributes] = []

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


extension WaterfallLayout {

    fileprivate class BuilderBundle {

        var itemWidthBuilder: (WaterfallLayoutSectionBasedParameter) -> ItemWidth
        var itemHeightBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat
        var itemSpacingBuilder: (WaterfallLayoutSectionBasedParameter) -> CGSize = { _ in .zero }

        var sectionInsetsBuilder: (WaterfallLayoutSectionBasedParameter) -> UIEdgeInsets = { _ in .zero }

        var numberOfSectionHeadersBuilder: (WaterfallLayoutSectionBasedParameter) -> Int = { _ in 0 }
        var sectionHeaderHeightBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat = { _ in 0 }
        var sectionHeaderInsetsBuilder: (WaterfallLayoutIndexPathBasedParameter) -> UIEdgeInsets = { _ in .zero }

        var numberOfSectionFootersBuilder: (WaterfallLayoutSectionBasedParameter) -> Int = { _ in 0 }
        var sectionFooterHeightBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat = { _ in 0 }
        var sectionFooterInsetsBuilder: (WaterfallLayoutIndexPathBasedParameter) -> UIEdgeInsets = { _ in .zero }


        init(itemWidthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ItemWidth, itemHeightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) {
            self.itemWidthBuilder = itemWidthBuilder
            self.itemHeightBuilder = itemHeightBuilder
        }

    }

}
