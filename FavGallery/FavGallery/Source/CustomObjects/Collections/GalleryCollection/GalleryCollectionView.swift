//
//  GalleryCollectionView.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

class GalleryCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    var pics: [Pic]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // called when built from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadFromNib("GalleryCollectionView") else { return }
        self.addSubview(view)
        setup()
    }
    
    // called when built from xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadFromNib("GalleryCollectionView") else { return }
        self.addSubview(view)
    }
    
    // like a viewDidLoad when built from xib
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "galleryCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        
        cell.pic = pics?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let interfaceOrientation = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.interfaceOrientation
        
        let screenSize: CGRect = UIScreen.main.bounds
        var width = screenSize.width / 3
        var height = screenSize.height / 6
        
        if interfaceOrientation?.isLandscape ?? false {
            width = screenSize.width / 6
            height = screenSize.width / 5
        }
        
        return CGSize(width: width , height: height)
    }
}
