//
//  FavoriteCoordinator.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import UIKit

class FavoriteCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var showingKind: ShowingKind = .push
    var viewController: CoordinatedController
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    
        let vc = FavoriteViewController.instantiate()
        viewController = vc
    }
}
  
