//
// Created by Alan on 2019-06-13.
// Copyright (c) 2019 Frog Lab. All rights reserved.
//


import Foundation
import UIKit


open class WaterfallLayout: DecorationViewSupportableLayout {

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


    public init(width widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) {
        self.builderBundle = BuilderBundle(itemSizeDescription: .sizeWithAlignment(widthBuilder: widthBuilder, heightBuilder: heightBuilder, alignmentBuilder: alignmentBuilder))
        super.init()
    }


    public convenience init(width: CGFloat, height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) {
        self.init(width: { _ in width }, height: heightBuilder, alignment: alignmentBuilder)
    }


    public convenience init(width widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, height: CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) {
        self.init(width: widthBuilder, height: { _ in height }, alignment: alignmentBuilder)
    }


    public convenience init(width widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) {
        self.init(width: widthBuilder, height: heightBuilder, alignment: { _ in alignment })
    }


    public convenience init(width: CGFloat, height: CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) {
        self.init(width: width, height: { _ in height }, alignment: alignmentBuilder)
    }


    public convenience init(width: CGFloat, height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) {
        self.init(width: width, height: heightBuilder, alignment: { _ in alignment })
    }


    public convenience init(width widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, height: CGFloat, alignment: ContentAlignment) {
        self.init(width: widthBuilder, height: height, alignment: { _ in alignment })
    }


    public convenience init(width: CGFloat, height: CGFloat, alignment: ContentAlignment) {
        self.init(width: width, height: height, alignment: { _ in alignment })
    }


    public init(width widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) {
        self.builderBundle = BuilderBundle(itemSizeDescription: .widthAndAspectRatioWithAlignment(widthBuilder: widthBuilder, aspectRatioBuilder: aspectRatioBuilder, alignmentBuilder: alignmentBuilder))
        super.init()
    }


    public convenience init(width: CGFloat, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) {
        self.init(width: { _ in width }, aspectRatio: aspectRatioBuilder, alignment: alignmentBuilder)
    }


    public convenience init(width widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatio: CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) {
        self.init(width: widthBuilder, aspectRatio: { _ in aspectRatio }, alignment: alignmentBuilder)
    }


    public convenience init(width widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) {
        self.init(width: widthBuilder, aspectRatio: aspectRatioBuilder, alignment: { _ in alignment })
    }


    public convenience init(width: CGFloat, aspectRatio: CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) {
        self.init(width: width, aspectRatio: { _ in aspectRatio }, alignment: alignmentBuilder)
    }


    public convenience init(width: CGFloat, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) {
        self.init(width: width, aspectRatio: aspectRatioBuilder, alignment: { _ in alignment })
    }


    public convenience init(width widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatio: CGFloat, alignment: ContentAlignment) {
        self.init(width: widthBuilder, aspectRatio: aspectRatio, alignment: { _ in alignment })
    }


    public convenience init(width: CGFloat, aspectRatio: CGFloat, alignment: ContentAlignment) {
        self.init(width: width, aspectRatio: aspectRatio, alignment: { _ in alignment })
    }


    public init(height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, numberOfColumns columnCountBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int) {
        self.builderBundle = BuilderBundle(itemSizeDescription: .heightAndColumnCount(heightBuilder: heightBuilder, columnCountBuilder: columnCountBuilder))
        super.init()
    }


    public convenience init(height: CGFloat, numberOfColumns columnCountBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int) {
        self.init(height: { _ in height }, numberOfColumns: columnCountBuilder)
    }


    public convenience init(height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, numberOfColumns: Int) {
        self.init(height: heightBuilder, numberOfColumns: { _ in numberOfColumns })
    }


    public convenience init(height: CGFloat, numberOfColumns: Int) {
        self.init(height: height, numberOfColumns: { _ in numberOfColumns })
    }


    public init(numberOfColumns columnCountBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) {
        self.builderBundle = BuilderBundle(itemSizeDescription: .columnCountAndAspectRatio(columnCountBuilder: columnCountBuilder, aspectRatioBuilder: aspectRatioBuilder))
        super.init()
    }


    public convenience init(numberOfColumns: Int, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) {
        self.init(numberOfColumns: { _ in numberOfColumns }, aspectRatio: aspectRatioBuilder)
    }


    public convenience init(numberOfColumns columnCountBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int, aspectRatio: CGFloat) {
        self.init(numberOfColumns: columnCountBuilder, aspectRatio: { _ in aspectRatio })
    }


    public convenience init(numberOfColumns: Int, aspectRatio: CGFloat) {
        self.init(numberOfColumns: numberOfColumns, aspectRatio: { _ in aspectRatio })
    }

}


public typealias WaterfallLayoutSectionBasedParameter = (collectionView: UICollectionView, layout: WaterfallLayout, section: Int)
public typealias WaterfallLayoutIndexPathBasedParameter = (collectionView: UICollectionView, layout: WaterfallLayout, indexPath: IndexPath)


extension WaterfallLayout {

    public enum ContentAlignment {

        case left
        case right
        case center

    }

}


extension WaterfallLayout {

    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) -> WaterfallLayout {
        self.builderBundle.itemSizeDescription = .sizeWithAlignment(widthBuilder: widthBuilder, heightBuilder: heightBuilder, alignmentBuilder: alignmentBuilder)
        return self
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: { _ in width }, height: heightBuilder, alignment: alignmentBuilder)
    }


    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, height: CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: widthBuilder, height: { _ in height }, alignment: alignmentBuilder)
    }


    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: widthBuilder, height: heightBuilder, alignment: { _ in alignment })
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, height: CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: width, height: { _ in height }, alignment: alignmentBuilder)
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, height heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: width, height: heightBuilder, alignment: { _ in alignment })
    }


    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, height: CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: widthBuilder, height: height, alignment: { _ in alignment })
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, height: CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: width, height: height, alignment: { _ in alignment })
    }


    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) -> WaterfallLayout {
        self.builderBundle.itemSizeDescription = .widthAndAspectRatioWithAlignment(widthBuilder: widthBuilder, aspectRatioBuilder: aspectRatioBuilder, alignmentBuilder: alignmentBuilder)
        return self
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: { _ in width }, aspectRatio: aspectRatioBuilder, alignment: alignmentBuilder)
    }


    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatio: CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: widthBuilder, aspectRatio: { _ in aspectRatio }, alignment: alignmentBuilder)
    }


    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: widthBuilder, aspectRatio: aspectRatioBuilder, alignment: { _ in alignment })
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, aspectRatio: CGFloat, alignment alignmentBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: width, aspectRatio: { _ in aspectRatio }, alignment: alignmentBuilder)
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: width, aspectRatio: aspectRatioBuilder, alignment: { _ in alignment })
    }


    @discardableResult
    open func setItemSize(withWidth widthBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatio: CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: widthBuilder, aspectRatio: aspectRatio, alignment: { _ in alignment })
    }


    @discardableResult
    open func setItemSize(withWidth width: CGFloat, aspectRatio: CGFloat, alignment: ContentAlignment) -> WaterfallLayout {
        return self.setItemSize(withWidth: width, aspectRatio: aspectRatio, alignment: { _ in alignment })
    }


    @discardableResult
    open func setItemSize(withHeight heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, numberOfColumns columnCountBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int) -> WaterfallLayout {
        self.builderBundle.itemSizeDescription = .heightAndColumnCount(heightBuilder: heightBuilder, columnCountBuilder: columnCountBuilder)
        return self
    }


    @discardableResult
    open func setItemSize(withHeight height: CGFloat, numberOfColumns columnCountBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int) -> WaterfallLayout {
        return self.setItemSize(withHeight: { _ in height }, numberOfColumns: columnCountBuilder)
    }


    @discardableResult
    open func setItemSize(withHeight heightBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, numberOfColumns: Int) -> WaterfallLayout {
        return self.setItemSize(withHeight: heightBuilder, numberOfColumns: { _ in numberOfColumns })
    }


    @discardableResult
    open func setItemSize(withHeight height: CGFloat, numberOfColumns: Int) -> WaterfallLayout {
        return self.setItemSize(withHeight: height, numberOfColumns: { _ in numberOfColumns })
    }


    @discardableResult
    open func setItemSize(withNumberOfColumns columnCountBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) -> WaterfallLayout {
        self.builderBundle.itemSizeDescription = .columnCountAndAspectRatio(columnCountBuilder: columnCountBuilder, aspectRatioBuilder: aspectRatioBuilder)
        return self
    }


    @discardableResult
    open func setItemSize(withNumberOfColumns columnCount: Int, aspectRatio aspectRatioBuilder: @escaping (WaterfallLayoutIndexPathBasedParameter) -> CGFloat) -> WaterfallLayout {
        return self.setItemSize(withNumberOfColumns: { _ in columnCount }, aspectRatio: aspectRatioBuilder)
    }


    @discardableResult
    open func setItemSize(withNumberOfColumns columnCountBuilder: @escaping (WaterfallLayoutSectionBasedParameter) -> Int, aspectRatio: CGFloat) -> WaterfallLayout {
        return self.setItemSize(withNumberOfColumns: columnCountBuilder, aspectRatio: { _ in aspectRatio })
    }


    @discardableResult
    open func setItemSize(withNumberOfColumns columnCount: Int, aspectRatio: CGFloat) -> WaterfallLayout {
        return self.setItemSize(withNumberOfColumns: columnCount, aspectRatio: { _ in aspectRatio })
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
        let itemSpacing = self.builderBundle.itemSpacingBuilder((collectionView, layout: self, section))

        let itemWidth = self.builderBundle.itemWidth(of: collectionView, layout: self, with: self.contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemSpacing.width, forSectionAt: section)
        let additionalLeftInset = self.builderBundle.additionalLeftInset(of: collectionView, layout: self, with: self.contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemSpacing.width, forSectionAt: section)
        let columnCount = self.builderBundle.columnCount(of: collectionView, layout: self, with: self.contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemSpacing.width, forSectionAt: section)

        let cellMinY = self.contentHeight
        var attributesInSection: [UICollectionViewLayoutAttributes] = []
        var lastFramesOfColumn: [CGRect] = []

        for item in 0 ..< collectionView.numberOfItems(inSection: section) {
            var targetColumnIndex = 0
            var leastMaxY = CGFloat.greatestFiniteMagnitude

            for index in 0 ..< columnCount {
                guard lastFramesOfColumn.count > index else {
                    let frame = CGRect(
                            x: sectionInsets.left + additionalLeftInset + CGFloat(index) * (itemWidth + itemSpacing.width),
                            y: cellMinY - itemSpacing.height,
                            width: itemWidth,
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
            frame.size.height = self.builderBundle.itemHeight(of: collectionView, layout: self, with: self.contentWidth, sectionInsets: sectionInsets, itemHorizontalSpacing: itemSpacing.width, forItemAt: indexPath)
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


extension WaterfallLayout {

    fileprivate enum ItemSizeDescription {

        case sizeWithAlignment(widthBuilder: (WaterfallLayoutSectionBasedParameter) -> CGFloat, heightBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignmentBuilder: (WaterfallLayoutSectionBasedParameter) -> ContentAlignment)
        case widthAndAspectRatioWithAlignment(widthBuilder: (WaterfallLayoutSectionBasedParameter) -> CGFloat, aspectRatioBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, alignmentBuilder: (WaterfallLayoutSectionBasedParameter) -> ContentAlignment)
        case heightAndColumnCount(heightBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat, columnCountBuilder: (WaterfallLayoutSectionBasedParameter) -> Int)
        case columnCountAndAspectRatio(columnCountBuilder: (WaterfallLayoutSectionBasedParameter) -> Int, aspectRatioBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat)

    }


    fileprivate class BuilderBundle {

        var itemSizeDescription: ItemSizeDescription

        var itemSpacingBuilder: (WaterfallLayoutSectionBasedParameter) -> CGSize = { _ in .zero }
        var sectionInsetsBuilder: (WaterfallLayoutSectionBasedParameter) -> UIEdgeInsets = { _ in .zero }

        var numberOfSectionHeadersBuilder: (WaterfallLayoutSectionBasedParameter) -> Int = { _ in 0 }
        var sectionHeaderHeightBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat = { _ in 0 }
        var sectionHeaderInsetsBuilder: (WaterfallLayoutIndexPathBasedParameter) -> UIEdgeInsets = { _ in .zero }

        var numberOfSectionFootersBuilder: (WaterfallLayoutSectionBasedParameter) -> Int = { _ in 0 }
        var sectionFooterHeightBuilder: (WaterfallLayoutIndexPathBasedParameter) -> CGFloat = { _ in 0 }
        var sectionFooterInsetsBuilder: (WaterfallLayoutIndexPathBasedParameter) -> UIEdgeInsets = { _ in .zero }


        init(itemSizeDescription: ItemSizeDescription) {
            self.itemSizeDescription = itemSizeDescription
        }


        func itemWidth(of collectionView: UICollectionView, layout: WaterfallLayout, with contentWidth: CGFloat, sectionInsets: UIEdgeInsets, itemHorizontalSpacing: CGFloat, forSectionAt section: Int) -> CGFloat {
            switch self.itemSizeDescription {
            case let .sizeWithAlignment(widthBuilder, _, _):
                return max(widthBuilder((collectionView, layout, section)), 0)

            case let .widthAndAspectRatioWithAlignment(widthBuilder, _, _):
                return max(widthBuilder((collectionView, layout, section)), 0)

            case let .heightAndColumnCount(_, columnCountBuilder):
                let columnCount = columnCountBuilder((collectionView, layout, section))
                let widthSumOfItems = contentWidth - sectionInsets.left - sectionInsets.right - CGFloat(columnCount - 1) * itemHorizontalSpacing

                guard columnCount > 0,
                      widthSumOfItems > 0 else {
                    return 0
                }

                return widthSumOfItems / CGFloat(columnCount)

            case let .columnCountAndAspectRatio(columnCountBuilder, _):
                let columnCount = columnCountBuilder((collectionView, layout, section))
                let widthSumOfItems = contentWidth - sectionInsets.left - sectionInsets.right - CGFloat(columnCount - 1) * itemHorizontalSpacing

                guard columnCount > 0,
                      widthSumOfItems > 0 else {
                    return 0
                }

                return widthSumOfItems / CGFloat(columnCount)
            }
        }


        func itemHeight(of collectionView: UICollectionView, layout: WaterfallLayout, with contentWidth: CGFloat, sectionInsets: UIEdgeInsets, itemHorizontalSpacing: CGFloat, forItemAt indexPath: IndexPath) -> CGFloat {
            switch self.itemSizeDescription {
            case let .sizeWithAlignment(_, heightBuilder, _):
                return max(heightBuilder((collectionView, layout, indexPath)), 0)

            case let .widthAndAspectRatioWithAlignment(widthBuilder, aspectRatioBuilder, _):
                let width = widthBuilder((collectionView, layout, indexPath.section))
                let aspectRatio = aspectRatioBuilder((collectionView, layout, indexPath))

                guard width > 0,
                      aspectRatio > 0 else {
                    return 0
                }

                return width / aspectRatio

            case let .heightAndColumnCount(heightBuilder, _):
                return max(heightBuilder((collectionView, layout, indexPath)), 0)

            case let .columnCountAndAspectRatio(columnCountBuilder, aspectRatioBuilder):
                let columnCount = columnCountBuilder((collectionView, layout, indexPath.section))
                let widthSumOfItems = contentWidth - sectionInsets.left - sectionInsets.right - CGFloat(columnCount - 1) * itemHorizontalSpacing
                let aspectRatio = aspectRatioBuilder((collectionView, layout, indexPath))

                guard columnCount > 0,
                      widthSumOfItems > 0,
                      aspectRatio > 0 else {
                    return 0
                }

                return widthSumOfItems / (CGFloat(columnCount) * aspectRatio)
            }
        }


        func additionalLeftInset(of collectionView: UICollectionView, layout: WaterfallLayout, with contentWidth: CGFloat, sectionInsets: UIEdgeInsets, itemHorizontalSpacing: CGFloat, forSectionAt section: Int) -> CGFloat {
            switch self.itemSizeDescription {
            case let .sizeWithAlignment(widthBuilder, _, alignmentBuilder):
                let width = widthBuilder((collectionView, layout, section))
                let extendedContentWidth = contentWidth - sectionInsets.left - sectionInsets.right + itemHorizontalSpacing
                let extendedItemWidth = width + itemHorizontalSpacing

                guard width > 0,
                      extendedContentWidth > 0,
                      extendedItemWidth > 0 else {
                    return 0
                }

                let columnCount = Int(extendedContentWidth / extendedItemWidth)

                switch alignmentBuilder((collectionView, layout, section)) {
                case .left:
                    return 0

                case .right:
                    return extendedContentWidth - CGFloat(columnCount) * extendedItemWidth

                case .center:
                    return (extendedContentWidth - CGFloat(columnCount) * extendedItemWidth) / 2
                }

            case let .widthAndAspectRatioWithAlignment(widthBuilder, _, alignmentBuilder):
                let width = widthBuilder((collectionView, layout, section))
                let extendedContentWidth = contentWidth - sectionInsets.left - sectionInsets.right + itemHorizontalSpacing
                let extendedItemWidth = width + itemHorizontalSpacing

                guard width > 0,
                      extendedContentWidth > 0,
                      extendedItemWidth > 0 else {
                    return 0
                }

                let columnCount = Int(extendedContentWidth / extendedItemWidth)

                switch alignmentBuilder((collectionView, layout, section)) {
                case .left:
                    return 0

                case .right:
                    return extendedContentWidth - CGFloat(columnCount) * extendedItemWidth

                case .center:
                    return (extendedContentWidth - CGFloat(columnCount) * extendedItemWidth) / 2
                }

            case .heightAndColumnCount:
                return 0

            case .columnCountAndAspectRatio:
                return 0
            }
        }


        func columnCount(of collectionView: UICollectionView, layout: WaterfallLayout, with contentWidth: CGFloat, sectionInsets: UIEdgeInsets, itemHorizontalSpacing: CGFloat, forSectionAt section: Int) -> Int {
            switch self.itemSizeDescription {
            case let .sizeWithAlignment(widthBuilder, _, _):
                let width = widthBuilder((collectionView, layout, section))
                let extendedContentWidth = contentWidth - sectionInsets.left - sectionInsets.right + itemHorizontalSpacing
                let extendedItemWidth = width + itemHorizontalSpacing

                guard width > 0,
                      extendedContentWidth > 0,
                      extendedItemWidth > 0 else {
                    return 0
                }

                return Int(extendedContentWidth / extendedItemWidth)

            case let .widthAndAspectRatioWithAlignment(widthBuilder, _, _):
                let width = widthBuilder((collectionView, layout, section))
                let extendedContentWidth = contentWidth - sectionInsets.left - sectionInsets.right + itemHorizontalSpacing
                let extendedItemWidth = width + itemHorizontalSpacing

                guard width > 0,
                      extendedContentWidth > 0,
                      extendedItemWidth > 0 else {
                    return 0
                }

                return Int(extendedContentWidth / extendedItemWidth)

            case let .heightAndColumnCount(_, columnCountBuilder):
                return max(columnCountBuilder((collectionView, layout, section)), 0)

            case let .columnCountAndAspectRatio(columnCountBuilder, _):
                return max(columnCountBuilder((collectionView, layout, section)), 0)
            }
        }

    }

}
