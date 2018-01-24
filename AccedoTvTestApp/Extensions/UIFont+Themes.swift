//
//  UIFont+Extension.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 23/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

public extension UIFont {
    
    static var headerViewTitle: UIFont = {
        return UIFont(name: "AvenirNext-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
    }()
    
    static var cellViewFont: UIFont = {
        return UIFont(name: "Avenir-Black", size: 20) ?? UIFont.systemFont(ofSize: 20)
    }()
    
}
