//
//  LobbyOddTableViewCell.swift
//  
//
//  Created by Yenting Chen on 2020/3/12.
//

import UIKit

class LobbyOddTableViewCell: UITableViewCell {
    
    var viewModel: LobbyTableViewCellViewModel? {
        didSet {
            bindViewModel()
        }
    }

    var singleImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(font: .NotoSansCJKtc_Regular, size: 15)
        label.textColor = .greyishBrown
        return label
    }()

    var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(font: .NotoSansCJKtc_Regular, size: 15)
        label.textColor = UIColor.brownishGrey
        return label
    }()
    
    private func bindViewModel() {
        if let url = URL(string: viewModel?.imageURLString ?? "") {
            singleImgView.kf.setImage(with: url)
        }
        titleLabel.text = viewModel?.titleText
        descriptionLabel.text = viewModel?.descriptionText
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subviewsConstraintSettingUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        subviewsConstraintSettingUp()
    }

    func subviewsConstraintSettingUp() {

        let subViews = [titleLabel, descriptionLabel, singleImgView]

        for view in subViews {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let singleImgViewConstraints = [
        singleImgView.topAnchor.constraint(equalTo: self.topAnchor),
        singleImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        singleImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        singleImgView.heightAnchor.constraint(equalToConstant: 170)]

        let titleLabelConstraints = [
        titleLabel.topAnchor.constraint(equalTo: singleImgView.bottomAnchor, constant: 12),
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)]

        let descriptionLabelConstraints = [
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)]

        let subViewConstraints = [singleImgViewConstraints, titleLabelConstraints, descriptionLabelConstraints]

        for constraints in subViewConstraints {
            NSLayoutConstraint.activate(constraints)
        }
    }

}

class LobbyEvenTableViewCell: UITableViewCell {
    
    var viewModel: LobbyTableViewCellViewModel? {
        didSet {
            bindViewModel()
        }
    }

    var leftImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var middleUpImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var middleDownImgView: UIImageView = {
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
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(font: .NotoSansCJKtc_Regular, size: 15)
        label.textColor = .greyishBrown
        return label
    }()

    var descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(font: .NotoSansCJKtc_Regular, size: 15)
        label.textColor = UIColor.brownishGrey
        return label
    }()
    
    private func bindViewModel() {
        titleLabel.text = viewModel?.titleText
        descriptionLabel.text = viewModel?.descriptionText
        if let leftUrl = URL(string: viewModel?.multiImagesURLString[0] ?? "") {
            leftImgView.kf.setImage(with: leftUrl)
        }
        if let middleUpUrl = URL(string: viewModel?.multiImagesURLString[1] ?? "") {
            middleUpImgView.kf.setImage(with: middleUpUrl)
        }
        if let middleDownUrl = URL(string: viewModel?.multiImagesURLString[2] ?? "") {
            middleDownImgView.kf.setImage(with: middleDownUrl)
        }
        if let rightUrl = URL(string: viewModel?.multiImagesURLString[3] ?? "") {
            rightImgView.kf.setImage(with: rightUrl)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subviewsConstraintSettingUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        subviewsConstraintSettingUp()
    }

    func subviewsConstraintSettingUp() {

        let subViews = [titleLabel, descriptionLabel, leftImgView, middleUpImgView, middleDownImgView, rightImgView]

        for view in subViews {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        let leftImgViewConstraints = [
        leftImgView.topAnchor.constraint(equalTo: self.topAnchor),
        leftImgView.widthAnchor.constraint(equalToConstant: 170),
        leftImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        leftImgView.heightAnchor.constraint(equalToConstant: 170)]
        
        let middleUpImgViewConstraints = [
        middleUpImgView.topAnchor.constraint(equalTo: self.topAnchor),
        middleUpImgView.widthAnchor.constraint(equalToConstant: 84),
        middleUpImgView.leadingAnchor.constraint(equalTo: leftImgView.trailingAnchor, constant: 2),
        middleUpImgView.heightAnchor.constraint(equalToConstant: 84)]
        
        let middleDownImgViewConstraints = [
        middleDownImgView.bottomAnchor.constraint(equalTo: leftImgView.bottomAnchor),
        middleDownImgView.widthAnchor.constraint(equalToConstant: 84),
        middleDownImgView.leadingAnchor.constraint(equalTo: leftImgView.trailingAnchor, constant: 2),
        middleDownImgView.heightAnchor.constraint(equalToConstant: 84)]
        
        let rightImgViewConstraints = [
        rightImgView.bottomAnchor.constraint(equalTo: leftImgView.bottomAnchor),
        rightImgView.leadingAnchor.constraint(equalTo: middleUpImgView.trailingAnchor, constant: 2),
        rightImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        rightImgView.heightAnchor.constraint(equalToConstant: 170)]

        let titleLabelConstraints = [
        titleLabel.topAnchor.constraint(equalTo: leftImgView.bottomAnchor, constant: 12),
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)]

        let descriptionLabelConstraints = [
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)]

        let subViewConstraints = [leftImgViewConstraints, titleLabelConstraints, descriptionLabelConstraints, middleUpImgViewConstraints, middleDownImgViewConstraints, rightImgViewConstraints]

        for constraints in subViewConstraints {
            NSLayoutConstraint.activate(constraints)
        }
    }

}
