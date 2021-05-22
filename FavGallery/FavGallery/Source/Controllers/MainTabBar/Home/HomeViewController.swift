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
    @IBOutlet weak private var alert: AlertView!
    
    private let picsService = PicsService()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        
        searchBar.delegate = self
        gallery.delegate = self
        
        //        let filter = randomDefaultFilter()
        let filter = "cat"
        searchBar.text = filter
        updateGallery(filter: filter)
        
        hideKeyboardWhenTappedAround()
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func updateGallery(filter: String) {
        picsService.get(by: filter) { [weak self] (pics) in
            self?.gallery.pics = pics
            
            DispatchQueue.main.async {
                self?.gallery.isHidden = pics?.count == 0
                self?.alert.isHidden = !(self?.gallery.isHidden ?? false)
            }
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
        let values = ["cat", "cats", "dog", "deer", "fish", "disney", "art", "duck"]
        return values[Int.random(in: 0..<values.count)]
    }
}
