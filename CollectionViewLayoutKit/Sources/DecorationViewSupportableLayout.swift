//
// Created by Alan on 2019-06-19.
// Copyright (c) 2019 Frog Lab. All rights reserved.
//


import Foundation
import UIKit


open class DecorationViewSupportableLayout: UICollectionViewLayout {

    var topSpaceForDecorationView: CGFloat = 0
    var bottomSpaceForDecorationView: CGFloat = 0

    var decorationViewKindList: [String] = []
    var decorationViewAttributes: [String: UICollectionViewLayoutAttributes] = [:]

    var decorationViewLayoutAttributesBuilder: (DecorationViewLayoutAttributesBuilderParameter) -> UICollectionViewLayoutAttributes? = { _ in nil }

}


public typealias DecorationViewLayoutAttributesBuilderParameter = (elementKind: String, layout: DecorationViewSupportableLayout)


extension DecorationViewSupportableLayout {

    public enum DecorationViewDescription {

        case viewClass(AnyClass?, ofKind: String)
        case nib(UINib?, ofKind: String)


        fileprivate var elementKind: String {
            switch self {
            case let .viewClass(_, elementKind):
                return elementKind

            case let .nib(_, elementKind):
                return elementKind
            }
        }

    }

}


extension DecorationViewSupportableLayout {

    @discardableResult
    open func register(_ descriptions: [DecorationViewDescription], topSpace: CGFloat = 0, bottomSpace: CGFloat = 0, builder: @escaping (DecorationViewLayoutAttributesBuilderParameter) -> UICollectionViewLayoutAttributes?) -> DecorationViewSupportableLayout {
        for description in descriptions {
            switch description {
            case let .viewClass(viewClass, elementKind):
                self.register(viewClass, forDecorationViewOfKind: elementKind)

            case let .nib(nib, elementKind):
                self.register(nib, forDecorationViewOfKind: elementKind)
            }
        }

        self.topSpaceForDecorationView = topSpace
        self.bottomSpaceForDecorationView = bottomSpace

        self.decorationViewKindList = descriptions.map { $0.elementKind }

        self.decorationViewLayoutAttributesBuilder = builder

        return self
    }

}


extension DecorationViewSupportableLayout {
    
    open override func invalidateLayout() {
        super.invalidateLayout()
        
        self.decorationViewAttributes = [:]
    }
    
}


extension DecorationViewSupportableLayout {
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect: [UICollectionViewLayoutAttributes] = []
        
        for kind in self.decorationViewKindList {
            guard let attributes = self.decorationViewLayoutAttributesBuilder((kind, layout: self)) else {
                continue
            }
            
            self.decorationViewAttributes[kind] = attributes
            
            if attributes.frame.intersects(rect) {
                attributesInRect.append(attributes)
            }
        }
        
        return attributesInRect
    }


    open override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.decorationViewAttributes[elementKind]
    }

}
