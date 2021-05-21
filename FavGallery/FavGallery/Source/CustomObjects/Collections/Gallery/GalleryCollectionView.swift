//
//  GalleryCollectionView.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

protocol GalleryDelegate: AnyObject {
    func didItemSelected(selectedIndex: Int)
}

class GalleryCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    weak var delegate: GalleryDelegate?
    
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
        
        let screenSize: CGRect = UIScreen.main.bounds
        let width = screenSize.width / 3
        let height = screenSize.height / 6
        return CGSize(width: width , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didItemSelected(selectedIndex: indexPath.item)
    }
}
