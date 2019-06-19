//
// Created by Alan on 2019-06-19.
// Copyright (c) 2019 Frog Lab. All rights reserved.
//


import Foundation
import UIKit


class Header: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red.withAlphaComponent(0.3)
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.red.withAlphaComponent(0.3)
    }

}
