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
    
    @IBOutlet weak private var searchBar: SearchBarView!
    @IBOutlet weak private var gallery: GalleryCollectionView!
    
    private let picsService = PicsService()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        
        searchBar.delegate = self
        gallery.delegate = self
        
        let filter = randomDefaultFilter()
        searchBar.text = filter
        updateGallery(filter: filter)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func updateGallery(filter: String) {
        picsService.get(by: filter) { [weak self] (pics) in
            self?.gallery.pics = pics
        }
    }
}

extension HomeViewController: SearchBarDelegate {
    
    func textDidChange(text: String?) {
        guard let filter = text else { return }
        updateGallery(filter: filter)
    }
}

extension HomeViewController: GalleryDelegate {
    
    func didItemSelected(selectedIndex: Int) {
        guard let pics = gallery.pics else { return }
        coordinator?.showCarousel(pics: pics, selectedIndex: selectedIndex)
    }
}

extension HomeViewController {
    
    private func randomDefaultFilter() -> String {
        let values = ["cat", "dog", "bird", "fish", "spider", "mouse", "frog"]
        return values[Int.random(in: 0..<values.count)]
    }
}
