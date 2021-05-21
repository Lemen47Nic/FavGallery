//
//  HomeViewController.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded, CoordinatedController {
    
    // MARK: Coordinator
    static var identifier: StoryboardIdentifier = .main

    var _coordinator: Coordinator?
    var coordinator: HomeCoordinator? {
        _coordinator as? HomeCoordinator
    }
    
    @IBOutlet weak private var gallery: GalleryCollectionView!
    
    private let picsService = PicsService()
    
    override func viewDidLoad() {
        picsService.get(by: "cat") { [weak self] (pics) in
            self?.gallery.pics = pics
        }
    }
}
