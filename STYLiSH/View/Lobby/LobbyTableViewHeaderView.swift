//
//  LobbyTableViewHeaderView.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import UIKit

class LobbyTableViewHeaderView: UITableViewHeaderFooterView {
    
    var viewModel: LobbyTableViewHeaderViewModel? {
        didSet {
            bindViewModel()
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyishBrown
        label.font = UIFont.setFont(font: .NotoSansCJKtc_Medium, size: 18)
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupLayout()
    }
    
    func bindViewModel() {
        self.titleLabel.text = viewModel?.titleText
    }

    private func setupLayout() {

        contentView.backgroundColor = .white

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)

        ])
    }

}
