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
    
    @IBOutlet weak private var carousel: CarouselCollectionView!
    
    var pics: [Pic]?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        carousel.pics = pics
    }
    
    override func viewDidLayoutSubviews() {
        carousel.scrollTo(index: selectedIndex)
    }
    
    @IBAction func close(_ sender: Any) {
        coordinator?.end()
    }
}
