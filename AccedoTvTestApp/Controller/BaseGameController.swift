//
//  BaseController.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 20/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "0"
        setLogo()
        setHighScoreBarButton()
        setNavBar()
    }

    private func setLogo() {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "logo"), for: .normal)
        button.addTarget(self, action: #selector(colourmemoryLogoPressed(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        let leftBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setHighScoreBarButton() {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "high_score"), for: .normal)
        button.addTarget(self, action: #selector(highScoreButtonPressed(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 28)
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func colourmemoryLogoPressed(_ sender: Any) {
        
    }
    
    @objc func highScoreButtonPressed(_ sender: Any) {
        
    }
    
}
