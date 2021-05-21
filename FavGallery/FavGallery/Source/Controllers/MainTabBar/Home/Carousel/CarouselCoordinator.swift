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
    
    init(navigationController: UINavigationController, pics: [Pic]) {
        self.navigationController = navigationController
    
        let vc = CarouselViewController.instantiate()
        vc.pics = pics
        viewController = vc
    }
}
