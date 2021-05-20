//
//  MainTabBarCoordinator.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    
    var showingKind: ShowingKind = .push
    var viewController: CoordinatedController
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let vc = MainTabBarViewController()
        viewController = vc
    }
    
    func start() {
        createTabs()
        
        viewController._coordinator = self
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func createTabs() {
        guard let viewController = viewController as? MainTabBarViewController else { return }
        var viewControllers: [UIViewController] = []
        for tabType in MainTabs.allCases {
            let tab = self.createTab(tabType)
            tab.tabCoordinator.parentCoordinator = self
            childCoordinators.append(tab.tabCoordinator)
            tab.tabCoordinator.start()
            viewControllers.append(tab.navigationController)
        }
        viewController.viewControllers = viewControllers
    }
    
    fileprivate func createTab(_ tab: MainTabs) -> (navigationController: UINavigationController, tabCoordinator: Coordinator){
        let navController = UINavigationController()
        navController.tabBarItem = tab.tabBarItem
        switch tab {
        case .cameraTab:
            let cameraCoordinator = CameraCoordinator(navigationController: navController)
            return (navController, cameraCoordinator)
        case .homeTab:
            let homeCoordinator = HomeCoordinator(navigationController: navController)
            return (navController, homeCoordinator)
        case .favoriteTab:
            let favoriteCoordinator = FavoriteCoordinator(navigationController: navController)
            return (navController, favoriteCoordinator)
        }
    }
}
