//
//  GalleryCollectionViewCell.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var image: UIImageView!
    
    var pic: Pic? {
        didSet {
            guard let thumbnailUrl = pic?.thumbnailUrl else { return }
            image.image(from: thumbnailUrl)
        }
    }
    
    // called when built from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadFromNib("GalleryCollectionViewCell") else { return }
        self.addSubview(view)
        setup()
    }
    
    // called when built from xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadFromNib("GalleryCollectionViewCell") else { return }
        self.addSubview(view)
    }
    
    // like a viewDidLoad when built from xib
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() { }
}
