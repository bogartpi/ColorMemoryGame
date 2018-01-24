//
//  BaseController.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 20/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

class BaseGameController: UIViewController {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "0"
        setLogo()
        setHighScoreBarButton()
        setNavBar(largeTitle: false)
    }

    /**
        Creates and sets a button as left bar button item
     */
    
    private func setLogo() {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "logo"), for: .normal)
        button.addTarget(self, action: #selector(colourmemoryLogoPressed(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        let leftBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    /**
     Creates and sets a button as right bar button item
     */
    
    private func setHighScoreBarButton() {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "high_score"), for: .normal)
        button.addTarget(self, action: #selector(highScoreButtonPressed(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func colourmemoryLogoPressed(_ sender: Any) {
        
    }
    
    @objc func highScoreButtonPressed(_ sender: Any) {
        
    }
    
}
