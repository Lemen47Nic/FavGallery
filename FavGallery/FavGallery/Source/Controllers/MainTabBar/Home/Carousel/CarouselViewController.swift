//
//  CarouselViewController.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

class CarouselViewController: UIViewController, Storyboarded, CoordinatedController {
    
    // MARK: Coordinator
    static var identifier: StoryboardIdentifier = .main

    var _coordinator: Coordinator?
    var coordinator: CarouselCoordinator? {
        _coordinator as? CarouselCoordinator
    }
    
    @IBAction func close(_ sender: Any) {
        coordinator?.end()
    }
}
