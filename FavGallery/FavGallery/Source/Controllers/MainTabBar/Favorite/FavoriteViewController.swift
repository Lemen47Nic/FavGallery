//
//  FavoriteViewController.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import UIKit

class FavoriteViewController: UIViewController, Storyboarded, CoordinatedController {
    
    // MARK: Coordinator
    static var identifier: StoryboardIdentifier = .main

    var _coordinator: Coordinator?
    var coordinator: FavoriteCoordinator? {
        _coordinator as? FavoriteCoordinator
    }
}
