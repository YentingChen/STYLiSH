//
//  STTabBarViewController.swift
//  STYLiSH
//
//  Created by Yenting Chen on 2020/2/12.
//  Copyright © 2020 Yenting Chen. All rights reserved.
//

import UIKit

private enum Tab {
    
    case lobby
    case product
    case profile
    case trolley
    
    func controller() -> UIViewController {
        
        var controller: UIViewController
        switch self {
        case .lobby:
            controller = UINavigationController(rootViewController: LobbyViewController())
        case .product:
            controller = UINavigationController(rootViewController: ProductViewController())
        case .profile:
            controller = UIViewController()
        case .trolley:
            controller = UIViewController()
        }
        
        controller.tabBarItem = tabBarItem()
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
        return controller
    }
    
    func tabBarItem() -> UITabBarItem {

        switch self {

        case .lobby:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.Icons_36px_Home_Normal),
                selectedImage: UIImage.asset(.Icons_36px_Home_Selected)
            )

        case .product:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.Icons_36px_Catalog_Normal),
                selectedImage: UIImage.asset(.Icons_36px_Catalog_Selected)
            )

        case .trolley:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.Icons_36px_Cart_Normal),
                selectedImage: UIImage.asset(.Icons_36px_Cart_Selected)
            )

        case .profile:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.Icons_36px_Profile_Normal),
                selectedImage: UIImage.asset(.Icons_36px_Profile_Selected)
            )
        }
    }
}

class STTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let tabs: [Tab] = [.lobby, .product, .trolley, .profile]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map({
            $0.controller()
        })
        
        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    
}
