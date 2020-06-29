//
//  UIButtonRounded.swift
//  transformers
//
//  Created by macintosh on 2020-06-29.
//  Copyright © 2020 aequilibrium. All rights reserved.
//

import UIKit

class UIButtonRounded: UIButton {
    let cornerRadius : CGFloat =  10.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
}
