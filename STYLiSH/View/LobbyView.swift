//
//  LobbyView.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import Foundation
import UIKit

protocol LobbyViewDelegate: UITableViewDelegate, UITableViewDataSource {
    
}
class LobbyView: UIView {
    
    var viewModel = LobbyViewViewModel() {
        didSet {
            bindViewModel()
        }
    }
    
    weak var delegate: LobbyViewDelegate? {
        didSet {
            tableView.delegate = self.delegate
            tableView.dataSource = self.delegate
        }
    }

    var tableView = UITableView(frame: CGRect()) {
        didSet {
            tableView.delegate = self.delegate
            tableView.dataSource = self.delegate
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupTableView()
    }

    private func setupTableView() {
        tableView.frame = self.frame
        self.addSubview(tableView)
        tableView.register(LobbyOddTableViewCell.self, forCellReuseIdentifier: String(describing: LobbyOddTableViewCell.self))
        tableView.register(LobbyEvenTableViewCell.self, forCellReuseIdentifier: String(describing: LobbyEvenTableViewCell.self))
        tableView.register(LobbyTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: LobbyTableViewHeaderView.self))
    }
    
    func bindViewModel() {
        viewModel.lobbyCells.bindAndFire { [weak self] (_) in
            self?.tableView.reloadData()
        }
        viewModel.lobbyHeaders.bindAndFire { [weak self] (_) in
            self?.tableView.reloadData()
        }
    }
}
