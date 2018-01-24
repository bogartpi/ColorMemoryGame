//
//  HeaderView.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 22/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customBackgroundColor
        return view
    }()
    
    let positionTitle: UILabel = {
        let label = UILabel(title: "Rank", font: .headerViewTitle,
                            color: .customPurpleColor, align: .left)
        return label
    }()
    
    let nameTitle: UILabel = {
        let label = UILabel(title: "Name", font: .headerViewTitle,
                            color: .customPurpleColor, align: .center)
        return label
    }()
    
    let scoreTitle: UILabel = {
        let label = UILabel(title: "Score", font: .headerViewTitle,
                            color: .customPurpleColor, align: .right)
        return label
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [positionTitle,
                                                       nameTitle,
                                                       scoreTitle])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(mainView)
        self.mainView.addSubview(headerStackView)
        mainView.snp.makeConstraints { (mainView) in
            mainView.edges.equalTo(self.snp.edges)
        }
        headerStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(mainView.snp.edges)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
