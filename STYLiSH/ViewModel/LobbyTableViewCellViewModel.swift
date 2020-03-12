//
//  LobbyTableViewCellViewModel.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/3/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

protocol LobbyTableViewCellViewModel {
    var productItem: ProductItem { get }
    var imageURLString: String { get }
    var titleText: String { get }
    var descriptionText: String { get }
    var multiImagesURLString: [String] { get }
}

extension ProductItem: LobbyTableViewCellViewModel {
    var multiImagesURLString: [String] {
        return self.images
    }
    
    var productItem: ProductItem {
        return self
    }
    
    var imageURLString: String {
        return self.mainImage
    }
    
    var descriptionText: String {
        return self.productDescription
    }
    
    var titleText: String {
        return self.title
    }
}

protocol LobbyTableViewHeaderViewModel {
    var hotsItem: HotsItem { get }
    var titleText: String { get }
}

extension HotsItem: LobbyTableViewHeaderViewModel {
    var hotsItem: HotsItem {
        return self
    }
    
    var titleText: String {
        return self.title
    }
}
