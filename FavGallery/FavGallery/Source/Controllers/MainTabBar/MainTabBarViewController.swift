//
//  MainTabBarViewController.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import UIKit

enum MainTabs: CaseIterable {
    
    case cameraTab
    case homeTab
    case favoriteTab
    
    var title: String {
        switch self {
        case .cameraTab:
            return "Camera"
        case .homeTab:
            return "Home"
        case .favoriteTab:
            return "Favorites"
        }
    }
    
    // TODO
    // Images should be "Rendered As Original" in  the assets
    var image: String {
        switch self {
        case .cameraTab:
            return "camera"
        case .homeTab:
            return "play.rectangle"
        case .favoriteTab:
            return "heart"
        }
    }
    
    // Images should be "Rendered As Original" in  the assets
    var selectedImage: String {
        switch self {
        case .cameraTab:
            return "camera.fill"
        case .homeTab:
            return "play.rectangle.fill"
        case .favoriteTab:
            return "heart.fill"
        }
    }
    
    var tag: Int {
        switch self {
        case .cameraTab:
            return 0
        case .homeTab:
            return 1
        case .favoriteTab:
            return 2
        }
    }
    
    var tabBarItem: UITabBarItem {
        let tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: self.image), selectedImage: UIImage(systemName: self.selectedImage))
        tabBarItem.tag = self.tag
        return tabBarItem
    }
}


class MainTabBarViewController: UITabBarController, CoordinatedController {
    
    var _coordinator: Coordinator?
    var coordinator: MainTabBarCoordinator? {
        _coordinator as? MainTabBarCoordinator
    }

    var firstOpening = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if firstOpening {
            selectedIndex = 1
            firstOpening = false
        }
        
        modalTransitionStyle = .crossDissolve
        tabBar.barTintColor = UIColor.black
        tabBar.tintColor = UIColor.white
    }
}
