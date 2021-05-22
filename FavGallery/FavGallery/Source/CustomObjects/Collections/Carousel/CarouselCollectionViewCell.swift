//
//  CarouselCollectionViewCell.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var zoomableImage: ZoomableImage!
    @IBOutlet weak var picInfoView: PicInfoView!
    
    var pic: Pic? {
        didSet {
            setupUI()
        }
    }
    
    // called when built from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadFromNib("CarouselCollectionViewCell") else { return }
        self.addSubview(view)
        setup()
    }
    
    // called when built from xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadFromNib("CarouselCollectionViewCell") else { return }
        self.addSubview(view)
    }
    
    // like a viewDidLoad when built from xib
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() { }
    
    private func setupUI() {
        guard let url = pic?.url else { return }
        zoomableImage.link = url
        
        picInfoView.title = pic?.title
        picInfoView.author = pic?.author
    }
}
