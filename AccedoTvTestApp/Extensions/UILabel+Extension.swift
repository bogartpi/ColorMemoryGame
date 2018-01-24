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
    
    public convenience init(title: String,
                            font: UIFont,
                            textColor: UIColor,
                            align: NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.textAlignment = align
    }
}

let scoreTitle: UILabel = {
    let label = UILabel()
    label.text = "Score"
    label.font = UIFont(name: "AvenirNext-Bold", size: 20)
    label.textColor = UIColor.customPurpleColor
    label.textAlignment = .right
    return label
}()
