//
//  UIFont+Extension.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/15.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import Foundation
import UIKit

 enum STFontName: String {
    case NotoSansCJKtc_Medium = "NotoSansCJKtc-Medium"
    case NotoSansCJKtc_Regular = "NotoSansCJKtc-Regular"
    
}

extension UIFont {
    static func setFont(font: STFontName, size: CGFloat) -> UIFont? {
        return UIFont(name: font.rawValue, size: size)
    }
}

