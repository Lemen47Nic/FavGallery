//
//  NavigationJumper.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import UIKit

extension UIApplication {
    var currentWindow: UIWindow? {
        connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    }
}

class NavigationJumper {
    
    static var shared = NavigationJumper()
    
    fileprivate var afterLoadingCoordinators: [Coordinator] = []
    
    // ************** FULL EXAMPLE ***********
    //    func test() {
    //        OwnershipPersistentRepository.getOwnerships { (result) in
    //
    //            guard let valuesOpt = result.value, let values = valuesOpt, let ownership = values.last, let connectedVehicle = ownership.connectedVehicle else { return }
    //
    //            self.jumpToTest(ownership: ownership, connectedVehicle: connectedVehicle)
    //        }
    //    }
    //
    //    class DDD: ConnectedServicesModalDelegate { }
    //
    //    func jumpToTest(ownership: OwnershipUnica2, connectedVehicle: ConnectedVehicle) {
    //
    //        let tab = MainTabs.homeTab
    //
    //        guard let firstCoordinator = self.getFirstCoordinator(of: tab) else { return }
    //
    //        let tabNavigationController = firstCoordinator.navigationController
    //
    //        let dashboardCoordinator = DashboardCoordinator(navigationController: tabNavigationController, ownership: ownership)
    //        let dashboardCoordinator2 = DashboardCoordinator(navigationController: tabNavigationController, ownership: ownership)
    //        let serviceCoordinator = ConnectedServicesCoordinator(navigationController: tabNavigationController, type: .valet, ownership: ownership, connectedVehicle: connectedVehicle, delegate: DDD(), withHexagonButton: false)
    //        let serviceCoordinator2 = ConnectedServicesCoordinator(navigationController: tabNavigationController, type: .valet, ownership: ownership, connectedVehicle: connectedVehicle, delegate: DDD(), withHexagonButton: false)
    //        let carSettingsCoordinator = CarSettingsCoordinator(navigationController: tabNavigationController, ownership: ownership)
    //        let pilopaCoordinator = PilopaCoordinator(navigationController: tabNavigationController, ownership: ownership)
    //
    //        afterLoadingCoordinators = [firstCoordinator, dashboardCoordinator, serviceCoordinator, dashboardCoordinator2, pilopaCoordinator, serviceCoordinator2, carSettingsCoordinator]
    //
    //        jumpToLoading(tab: tab, ownership: ownership)
    //    }
    // ************** FULL EXAMPLE END ***********
    
    func jumpToHome() {
        let tab = MainTabs.homeTab
        
        guard let firstCoordinator = self.getFirstCoordinator(of: tab) else { return }
        
        self.jumpTo(coordinators: [firstCoordinator])
    }
    
    //    func jumpToProfile(tab: MainTabs, profile: Profile, checkLoading: Bool = true) {
    //        guard let firstCoordinator = self.getFirstCoordinator(of: tab) else { return }
    //
    //        let tabNavigationController = firstCoordinator.navigationController
    //
    //        let profileCoordinator = ProfileCoordinator(navigationController: tabNavigationController, profile: profile)
    //
    //        afterLoadingCoordinators = [firstCoordinator, dashboardCoordinator]
    //        if checkLoading {
    //            jumpToLoading(tab: tab, profile: profile)
    //        } else {
    //            jumpAfterLoading()
    //        }
    //    }
}

// loading dashboard split
extension NavigationJumper {
    
    // to call when the new stack has dashboard
    //    fileprivate func jumpToLoading(tab: MainTabs, profile: Profile) {
    //        guard let firstCoordinator = self.getFirstCoordinator(of: tab) else { return }
    //
    //        let tabNavigationController = firstCoordinator.navigationController
    //
    //        let loadingCoordinator = ProfileLoadingCoordinator(navigationController: tabNavigationController, profile: profile, isJumping: true)
    //
    //        switch profile.shouldShowType {
    //        case .profile, .toSignUp, .detail:
    //            jumpAfterLoading()
    //        case .loading:
    //            jumpTo(coordinators: [firstCoordinator, loadingCoordinator])
    //        }
    //    }
    
    // call only after loading completed
    func jumpAfterLoading() {
        jumpTo(coordinators: afterLoadingCoordinators)
        afterLoadingCoordinators = []
    }
}

// private utilities
extension NavigationJumper {
    
    func getFirstCoordinator(of tab: MainTabs) -> Coordinator? {
        guard let mainNavigationController = UIApplication.shared.currentWindow?.rootViewController as? UINavigationController,
              let vc = mainNavigationController.viewControllers.filter({$0 is MainTabBarViewController}).first,
              let index = mainNavigationController.viewControllers.firstIndex(of: vc),
              let mainViewController = mainNavigationController.viewControllers[index] as? MainTabBarViewController,
              let mainCoordinator = mainViewController.coordinator,
              mainCoordinator.childCoordinators.count > tab.tag
        else { return nil }
        
        switchMainTab(to: tab, mainCoordinator: mainCoordinator)
        
        return mainCoordinator.childCoordinators[tab.tag]
    }
    
    fileprivate func switchMainTab(to tab: MainTabs, mainCoordinator: Coordinator) {
        guard let mainViewController = mainCoordinator.viewController as? MainTabBarViewController else { return }
        
        let currentCoordinator = mainCoordinator.childCoordinators[mainViewController.selectedIndex]
        currentCoordinator.navigationController.navigationController?.dismiss(animated: false, completion: nil)
        
        if mainViewController.selectedIndex != tab.tag {
            currentCoordinator.navigationController.popToRootViewController(animated: false)
            mainViewController.selectedIndex = tab.tag
        }
        
    }
    
    // coordinators can be double but only if are not the same object
    fileprivate func jumpTo(coordinators: [Coordinator]) {
        
        var viewControllers = [coordinators[0].viewController]
        var navigationController = coordinators[0].navigationController
        
        coordinators[0].viewController._coordinator = coordinators[0]
        
        for i in 1..<coordinators.count {
            let coordinator = coordinators[i]
            coordinator.viewController._coordinator = coordinator
            coordinator.parentCoordinator = coordinators[i - 1]
            coordinators[i - 1].childCoordinators.append(coordinator)
            
            if coordinator.showingKind == .present {
                navigationController.viewControllers = viewControllers
                viewControllers = []
                
                let navController = UINavigationController(rootViewController: coordinator.viewController)
                navController.modalPresentationStyle = .fullScreen
                navigationController.present(navController, animated: false) // animated has to be false
                // actual coordinator have to use parent navigation controller to open the new one
                // and then set the new one as its navigation controller
                navigationController = navController
            }
            
            // for both push and present
            viewControllers.append(coordinator.viewController)
            coordinator.navigationController = navigationController
        }
        
        navigationController.setViewControllers(viewControllers, animated: true)
    }
}
