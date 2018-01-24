//
//  UIColor+Themes.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 20/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}

public extension UIColor {
    
    static var customBackgroundColor: UIColor = {
        return UIColor(r: 37, g: 37, b: 38)
    }()
    
    static var customGrayColor: UIColor = {
        return UIColor(white: 0.9, alpha: 0.98)
    }()
    
    static var customPurpleColor: UIColor = {
        return UIColor(r: 159, g: 139, b: 226)
    }()

}
