//
//  UILabel+Extension.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 23/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     Convenient initializer of UILabel
     */
    
    public convenience init(title: String = String(), font: UIFont,
                            color: UIColor, align: NSTextAlignment = .left) {
        self.init()
        self.text = title
        self.font = font
        self.textColor = color
        self.textAlignment = align
    }
}
