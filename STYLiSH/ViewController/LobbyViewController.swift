//
//  LobbyViewController.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/2/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import UIKit
import Foundation


class LobbyViewController: UIViewController {
    
    let marketProvider = MarketProvider()
    
    var lobbyView = LobbyView() {
        didSet {
            lobbyView.delegate = self
        }
    }
    
    var datas: [PromotedProducts] = [] {
        
        didSet {
            lobbyView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lobbyView = LobbyView(frame: self.view.frame)
        self.view.addSubview(lobbyView)
        fetchData()
    }
    
    func fetchData() {
        marketProvider.fetchHots { [weak self] (result) in
            switch result {
            case .success(let products):

                self?.datas = products

            case .failure:
                break
            }
        }
    }
    
}

extension LobbyViewController: LobbyViewDelegate {
    
    func triggerRefresh(_ lobbyView: LobbyView) {
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LobbyTableViewCell.self), for: indexPath)

        guard let lobbyCell = cell as? LobbyTableViewCell else { return cell }

        let product = datas[indexPath.section].products[indexPath.row]

        if indexPath.row % 2 == 0 {

            lobbyCell.singlePage(img: product.mainImage, title: product.title, description: product.description)

        } else {

            lobbyCell.multiplePages(imgs: product.images, title: product.title, description: product.description)
        }

        return lobbyCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 258
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 67.0 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: LobbyTableViewHeaderView.self)) as? LobbyTableViewHeaderView else { return nil }
        
        headerView.titleLabel.text = datas[section].title
        
        return headerView
    }

}

protocol LobbyViewDelegate: AnyObject, UITableViewDelegate, UITableViewDataSource {
    
    func triggerRefresh(_ lobbyView: LobbyView)
}

class LobbyView: UIView {
    
    weak var delegate: LobbyViewDelegate? {
        didSet {
            tableView.dataSource = self.delegate
            tableView.delegate = self.delegate
        }
    }
    
    var tableView = UITableView(frame: CGRect(), style: .grouped) {
        
        didSet {
            tableView.dataSource = self.delegate
            tableView.delegate = self.delegate
        }
    }
    
    func beginHeaderRefresh() {
        
    }
    
    func reloadData() {
    
        tableView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        tableView.register(LobbyTableViewCell.self, forCellReuseIdentifier: String(describing: LobbyTableViewCell.self))
        tableView.register(LobbyTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: LobbyTableViewHeaderView.self))
        self.delegate?.triggerRefresh(self)
    }
}


class LobbyTableViewCell: UITableViewCell {
    
    var singleImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var leftImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var middleTopImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var middleBottomImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var rightImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var titleLabel =  UILabel()

    var descriptionLabel =  UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subviewsConstraintSettingUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        subviewsConstraintSettingUp()
    }
    
    func subviewsConstraintSettingUp() {

        let subViews = [leftImgView, middleTopImgView, middleBottomImgView, rightImgView, titleLabel, descriptionLabel, singleImgView]
        
        for view in subViews {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let singleImgViewConstraints = [
        singleImgView.topAnchor.constraint(equalTo: self.topAnchor),
        singleImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        singleImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        singleImgView.heightAnchor.constraint(equalToConstant: 170)]

        let leftImgViewConstraints = [
        leftImgView.topAnchor.constraint(equalTo: self.topAnchor),
        leftImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        leftImgView.widthAnchor.constraint(equalToConstant: 170),
        leftImgView.heightAnchor.constraint(equalToConstant: 170)]

        let middleTopImgViewConstraints = [
        middleTopImgView.topAnchor.constraint(equalTo: self.topAnchor),
        middleTopImgView.leadingAnchor.constraint(equalTo: leftImgView.trailingAnchor, constant: 2),
        middleTopImgView.widthAnchor.constraint(equalToConstant: 84),
        middleTopImgView.heightAnchor.constraint(equalToConstant: 84)]

        let middleBottomImgViewConstraints = [
        middleBottomImgView.topAnchor.constraint(equalTo: middleTopImgView.bottomAnchor, constant: 2),
        middleBottomImgView.leadingAnchor.constraint(equalTo: leftImgView.trailingAnchor, constant: 2),
        middleBottomImgView.widthAnchor.constraint(equalToConstant: 84),
        middleBottomImgView.heightAnchor.constraint(equalToConstant: 84)]

        let rightImgViewConstraints = [
        rightImgView.topAnchor.constraint(equalTo: self.topAnchor),
        rightImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        rightImgView.widthAnchor.constraint(equalToConstant: 85),
        rightImgView.heightAnchor.constraint(equalToConstant: 170)]

        let titleLabelConstraints = [
        titleLabel.topAnchor.constraint(equalTo: singleImgView.bottomAnchor, constant: 12),
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)]

        let descriptionLabelConstraints = [
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)]

        let subViewConstraints = [singleImgViewConstraints, leftImgViewConstraints, middleTopImgViewConstraints, middleBottomImgViewConstraints, rightImgViewConstraints, titleLabelConstraints, descriptionLabelConstraints]

        for constraints in subViewConstraints {
            NSLayoutConstraint.activate(constraints)
        }
    }

    
    func singlePage(img: String, title: String, description: String) {

        singleImgView.alpha = 1.0

        singleImgView.loadImage(urlString: img, placeHolder: UIImage.asset(.Image_Placeholder))

        titleLabel.text = title

        descriptionLabel.text = description
    }

    func multiplePages(imgs: [String], title: String, description: String) {

        singleImgView.alpha = 0.0

        leftImgView.loadImage(urlString: imgs[0], placeHolder: UIImage.asset(.Image_Placeholder))

        middleTopImgView.loadImage(urlString: imgs[1], placeHolder: UIImage.asset(.Image_Placeholder))

        middleBottomImgView.loadImage(urlString: imgs[2], placeHolder: UIImage.asset(.Image_Placeholder))

        rightImgView.loadImage(urlString: imgs[3], placeHolder: UIImage.asset(.Image_Placeholder))

        titleLabel.text = title

        descriptionLabel.text = description
    }
    
}
class LobbyTableViewHeaderView: UITableViewHeaderFooterView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
