//
// Created by Alan on 2019-06-13.
// Copyright (c) 2019 Frog Lab. All rights reserved.
//


import Foundation


enum CollectionViewLayoutKitError: LocalizedError {

    case nilCollectionView
    case failToCalculateCellSizes(reason: String)


    var errorDescription: String? {
        let description: String

        switch self {
        case .nilCollectionView:
            description = "The related collection view is nil."

        case .failToCalculateCellSizes:
            description = "Fail to calculate cell sizes."
        }

        if let reason = self.failureReason {
            return "\n[CollectionViewLayoutKit] \(description)\nReason: \(reason)\n" 
        } else {
            return "\n[CollectionViewLayoutKit] \(description)\n"
        }
    }

    var failureReason: String? {
        switch self {
        case .nilCollectionView:
            return nil

        case let .failToCalculateCellSizes(reason):
            return reason
        }
    }

}
