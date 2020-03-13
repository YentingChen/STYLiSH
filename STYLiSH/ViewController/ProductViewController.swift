//
//  ProductViewController.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/13.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import UIKit
import Foundation

class ProductViewController: UIViewController {
    var codeSegmented = CustomSegmentedControl()
    var redButton = UIButton()
    var orangeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        codeSegmented.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
        codeSegmented.selectedIndex = 0
        view.addSubview(codeSegmented)
        redButton.frame =  CGRect(x: 0, y: 300, width: 50, height: 50)
        redButton.backgroundColor = .red
        orangeButton.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        orangeButton.backgroundColor = .orange
        view.addSubview(redButton)
        view.addSubview(orangeButton)
        
        redButton.addTarget(self, action: #selector(redButtonTapped), for: .touchUpInside)
        orangeButton.addTarget(self, action: #selector(orangeButtonTapped), for: .touchUpInside)
        codeSegmented.setButtonTitles(buttonTitles: ["女裝", "男裝", "配件"])
        codeSegmented.selectorTextColor = UIColor.black
        codeSegmented.selectorViewColor = UIColor.black
        codeSegmented.textColor = UIColor.black.withAlphaComponent(0.25)
    }
    
    @objc func redButtonTapped() {
        codeSegmented.selectedIndex = 0
    }
    
    @objc func orangeButtonTapped() {
        codeSegmented.selectedIndex = 1
    }
}
