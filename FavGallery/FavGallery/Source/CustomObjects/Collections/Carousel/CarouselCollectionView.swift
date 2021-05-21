//
//  CarouselCollectionView.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

class CarouselCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    var pics: [Pic]?
    
    // called when built from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadFromNib("CarouselCollectionView") else { return }
        self.addSubview(view)
        setup()
    }
    
    // called when built from xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadFromNib("CarouselCollectionView") else { return }
        self.addSubview(view)
    }
    
    // like a viewDidLoad when built from xib
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "carouselCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        
        cell.pic = pics?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let width = screenSize.width
        let height = screenSize.height
        return CGSize(width: width , height: height)
    }
    
    func scrollTo(index: Int) {
        DispatchQueue.main.async{ [weak self] in
            // For iOS 14 - Apparently there is a new bug in UICollectionView that is causing scrollToItem to not work when paging is enabled.
            self?.collectionView.isPagingEnabled = false
            self?.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
            self?.collectionView.isPagingEnabled = true
         }
    }
}
