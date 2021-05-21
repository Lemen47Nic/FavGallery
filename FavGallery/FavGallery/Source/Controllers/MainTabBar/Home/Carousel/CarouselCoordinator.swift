//
//  CarouselCoordinator.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

class CarouselCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var showingKind: ShowingKind = .present
    var viewController: CoordinatedController
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    
        let vc = CarouselViewController.instantiate()
        viewController = vc
    }
}
