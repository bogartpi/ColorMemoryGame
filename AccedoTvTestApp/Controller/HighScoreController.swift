//
//  HighScoreController.swift
//  AccedoTvTestApp
//
//  Created by Pavel Bogart on 20/01/2018.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class HighScoreController: UIViewController {
    
    // MARK: - Properties
    
    private var realm: Realm!
    private var scores: Results<Score> {
        get {
            return realm.objects(Score.self)
        }
    }
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 50
        tv.backgroundColor = .customBackgroundColor
        tv.allowsSelection = false
        tv.separatorStyle = .none
        return tv
    }()
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.backgroundColor = UIColor.customBackgroundColor
        return view
    }()
    
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Play the game and save your best score!"
        label.textColor = UIColor(white: 0.7, alpha: 0.4)
        label.font = UIFont(name: "Avenir-Medium", size: 15)
        label.numberOfLines = 3
        return label
    }()
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        setupNavigationbar()
        setupViews()
    }
    
    // MARK: - Setup Views
    
    private func setupNavigationbar() {
        title = "High Scores"
        setupCloseButton()
        setupResetButton()
        setNavBar(largeTitle: true)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.customBackgroundColor
        tableView.register(ScoreCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        headerView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view.snp.topMargin).inset(8)
            make.left.equalTo(self.view.snp.left).inset(20)
            make.right.equalTo(self.view.snp.right).inset(20)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    // MARK: - Setup Navigationbar Buttons
    
    private func setupCloseButton() {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitleColor(UIColor.init(white: 0.95, alpha: 0.97), for: .normal)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupResetButton() {
        let button = UIButton(type: .custom)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(resetHighScoreDatabase), for: .touchUpInside)
        button.setTitleColor(UIColor.init(white: 0.95, alpha: 0.97), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
        let leftBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    // MARK: - Functions

    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func resetHighScoreDatabase() {
        showConfirmAlert()
    }
    
    private func deleteDataFromDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /**
     Confirm scores delition by showing alert sheet
     */
    
    private func showConfirmAlert() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let resetAction = UIAlertAction(title: "Reset Scores", style: .destructive) { (action) in
            self.deleteDataFromDatabase()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertVC.addAction(resetAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    /**
     Sorts objects from RealmDatabase and sets them to a custom cell.
     
     - Parameter cell: The custom cell of type ScoreCell.
     - Parameter indexPath: An index path locating a row in tableView.
     */
    
    private func configure(with cell: ScoreCell, at indexPath: IndexPath) {
        var positions = [Int]()
        var sortedScores = scores.sorted {
            $0.points > $1.points
        }
        let score = sortedScores[indexPath.row]
        for position in 1...scores.count {
            positions.append(position)
        }
        cell.positionLabel.text = "№\(positions[indexPath.row])"
        cell.nameLabel.text = score.name
        cell.scoreLabel.text = "\(score.points)"
    }

}

// MARK: - TableView Methods

extension HighScoreController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if scores.count == 0 {
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
            self.headerView.isHidden = true
            return 0
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .none
            self.headerView.isHidden = false
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ScoreCell
        configure(with: cell, at: indexPath)
        return cell
    }
}
