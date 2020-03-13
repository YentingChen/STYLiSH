//
//  LobbyViewController.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/2/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import UIKit
import Foundation

class LobbyViewController: UIViewController{
    
    
    var lobbyView = LobbyView() {
        didSet {
            lobbyView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettingUp()
        lobbyView.viewModel.getHots()
        UISegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func tableViewSettingUp() {
        lobbyView.frame = self.view.frame
        lobbyView.tableView.delegate = self
        lobbyView.tableView.dataSource = self
        self.view.addSubview(lobbyView)
    }
}

extension LobbyViewController: LobbyViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lobbyView.viewModel.lobbyCells.value[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return lobbyView.viewModel.lobbyHeaders.value.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch lobbyView.viewModel.lobbyCells.value[indexPath.section][indexPath.row]{
        case .normal(let cellViewModel):
            if indexPath.row % 2 == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LobbyEvenTableViewCell.self)) as? LobbyEvenTableViewCell else {
                    return UITableViewCell()
                }
                cell.viewModel = cellViewModel
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LobbyOddTableViewCell.self)) as? LobbyOddTableViewCell else {
                    return UITableViewCell()
                }
                cell.viewModel = cellViewModel
                return cell
            }
            
        case .error(let data):
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = data?.description
            return cell
        case .empty:
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = "No data available"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 67.0 }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch lobbyView.viewModel.lobbyHeaders.value[section] {
        case .normal(let headerViewModel):
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: LobbyTableViewHeaderView.self)) as? LobbyTableViewHeaderView else { return nil }
            headerView.viewModel = headerViewModel
            return headerView
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch lobbyView.viewModel.lobbyCells.value[0][indexPath.row] {
        case .normal:
            return 300
        default:
            return 100
        }
    }

}
