//
//  CustomSegmentedControl.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/13.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UIView {
    
    private var buttonTitles: [String] = ["選擇 0", "選擇 1"]
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    
    var textColor: UIColor = .black
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red
    var selectedIndex: Int = 0 {
        didSet {
            selectedButtonChangedAction(selectedIndex: selectedIndex)
        }
        
    }
    
    private func selectedButtonChangedAction(selectedIndex: Int) {
        guard buttons.count > 1 else { return }
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(selectedIndex)
        UIView.animate(withDuration: 0.3) {
            self.selectorView.frame.origin.x = selectorPosition
        }
        for (buttonIndex, btn) in buttons.enumerated(){
            if buttonIndex == selectedIndex {
                btn.isSelected = true
            } else {
                btn.isSelected = false
            }
        }
        
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(selectedIndex)
        selectorView = UIView(frame: CGRect(x: selectorPosition, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
        
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({ $0.removeFromSuperview() })
        for buttonTitle in buttonTitles {
            let button = UIButton()
            button.backgroundColor = .white
            button.setTitleColor(textColor, for: .normal)
            button.setTitleColor(selectorTextColor, for: .selected)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated(){
            if btn == sender {
                selectedIndex = buttonIndex
            }
        }
        
//        for (buttonIndex, btn) in buttons.enumerated() {
//            btn.isSelected = false
//            if btn == sender {
//                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
//                selectedIndex = buttonIndex
//
//                UIView.animate(withDuration: 0.3) {
//                    self.selectorView.frame.origin.x = selectorPosition
//                }
//                btn.isSelected = true
//            } else {
//                btn.isSelected = false
//            }
//        }
    }
    
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
        for index in 0...(buttons.count - 1) {
            if index != selectedIndex {
                buttons[index].isSelected = false
            } else {
                buttons[index].isSelected = true
            }
        }
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
    }
}
