//
//  UIColor+Extension.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/15.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    static let greyishBrown = UIColor(r: 63, g: 58, b: 58)
    static let brownishGrey = UIColor(r: 100, g: 100, b: 100)
    static let brownGrey = UIColor(r: 136, g: 136, b: 136)
    static let black25 = UIColor(r: 0, g: 0, b: 0).withAlphaComponent(0.25)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
}
