//
//  KingFisherWrapper.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/2/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(urlString: String?, placeHolder: UIImage? = nil) {
        guard let urlString = urlString else { return }
        let url = URL(string: urlString)
        self.kf.setImage(with:url, placeholder: placeHolder)
    }
}
