//
//  ScoreCell.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 20/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit
import SnapKit

class ScoreCell: UITableViewCell {
    
    let positionLabel: UILabel = {
        let label = UILabel(font: .cellViewFont, color: .customGrayColor)
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(font: .cellViewFont, color: .customGrayColor, align: .center)
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel(font: .cellViewFont, color: .customGrayColor, align: .center)
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return label
    }()
    
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [positionLabel,
                                                       nameLabel,
                                                       scoreLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    let separtorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.7)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.customBackgroundColor
        
        self.addSubview(cellStackView)
        self.addSubview(separtorView)
        
        cellStackView.snp.makeConstraints { (cellStackView) in
            cellStackView.left.equalTo(self.snp.left).inset(24)
            cellStackView.right.equalTo(self.snp.right).inset(12)
            cellStackView.centerY.equalTo(self.snp.centerY)
            cellStackView.height.equalTo(40)
        }
        
        separtorView.snp.makeConstraints { (make) in
            make.bottom.equalTo(cellStackView.snp.bottom)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
