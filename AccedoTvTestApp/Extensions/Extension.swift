//
//  Extensions.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 19/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit
import Foundation

extension Array {
    
    /**
     Gives the random order of array objects
     */
    mutating func shuffle() {
        for _ in 0...self.count {
            self.sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

extension UIViewController {
    
    /**
     Configures navigationBar title, background and its items
     */
    func setNavBar(largeTitle: Bool) {
        let atts = [NSAttributedStringKey.foregroundColor: UIColor.white,
                    NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
        navigationController?.navigationBar.titleTextAttributes = atts
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 36/255, green: 36/255, blue: 38/255, alpha: 1.0)
        if #available(iOS 11.0, *) {
            let atts = [NSAttributedStringKey.foregroundColor: UIColor.init(white: 0.95, alpha: 0.97) ]
            navigationController?.navigationBar.largeTitleTextAttributes = atts
            navigationController?.navigationBar.prefersLargeTitles = largeTitle
        }
    }
}


