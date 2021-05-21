//
//  Coordinator.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation
import UIKit

enum ShowingKind {
    case push
    case present
}

protocol CoordinatedController: UIViewController {
    var _coordinator: Coordinator? { get set }
}

protocol Coordinator: class {
    
    var showingKind: ShowingKind { get set }
    var navigationController: UINavigationController { get set }
    var viewController: CoordinatedController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    // actually only MainTabBar coordinator has more then one child
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func end()
}

extension Coordinator {
    
    func start() {
        viewController._coordinator = self
        
        switch showingKind {
        case .push:
            navigationController.pushViewController(viewController, animated: true)
        case .present:
            let navController = UINavigationController(rootViewController: viewController)
            navController.modalPresentationStyle = .fullScreen
            navigationController.present(navController, animated: true)
            // actual coordinator have to use parent navigation controller to open the new one
            // and then set the new one as its navigation controller
            navigationController = navController
        }
    }
    
    func end() {
        switch showingKind {
        case .push:
            navigationController.popViewController(animated: true)
        case .present:
            navigationController.dismiss(animated: true, completion: nil)
        }
        
        if let parentCoorindator = parentCoordinator {
            cleanAllChildren(parentCoorindator)
        }
    }
    
    func cleanAllChildren(_ parentCoordinator: Coordinator) {
        if parentCoordinator.childCoordinators.count > 0 {
            cleanAllChildren(parentCoordinator.childCoordinators[0])
            parentCoordinator.childCoordinators[0].viewController._coordinator = nil
            parentCoordinator.childCoordinators.removeAll()
        }
    }
    
    func find<T>(_ parentCoordinator: Coordinator?, type: T.Type) -> Coordinator? {
        guard let parentCoordinator = parentCoordinator else { return nil}
        
        if let coordinator = parentCoordinator as? T,
           let result = coordinator as? Coordinator {
            return result
        } else {
            return find(parentCoordinator.parentCoordinator, type: type)
        }
    }
    
    func replaceCurrentCoordindator(with newCoordinator: Coordinator) {
        
        // set new coordinator
        newCoordinator.viewController._coordinator = newCoordinator
        newCoordinator.showingKind = showingKind // new coordinator has to use same kind of navigation
        
        // clean this coordinator
        viewController._coordinator = nil
        parentCoordinator?.childCoordinators.removeLast()
        
        // replace
        parentCoordinator?.childCoordinators.append(newCoordinator)
        newCoordinator.parentCoordinator = parentCoordinator
        
        navigationController.setViewControllers([newCoordinator.viewController], animated: true)
    }
    
    func removeLastCoordinatorFromStack() {
        parentCoordinator?.childCoordinators.removeLast()
        navigationController.viewControllers.removeLast()
    }
}
