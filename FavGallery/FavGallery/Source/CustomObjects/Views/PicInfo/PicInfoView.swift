//
//  PicInfoView.swift
//  FavGallery
//
//  Created by naspes on 22/05/21.
//

import UIKit

class PicInfoView: UIView, UIScrollViewDelegate {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var authorLabel: UILabel!
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            titleLabel.text = "Title: \(title)"
        }
    }
    
    var author: String? {
        didSet {
            guard let author = author else { return }
            authorLabel.text = "Author: \(author)"
        }
    }
    
    // called when built from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadFromNib("PicInfoView") else { return }
        self.addSubview(view)
        setup()
    }
    
    // called when built from xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadFromNib("PicInfoView") else { return }
        self.addSubview(view)
    }
    
    // like a viewDidLoad when built from xib
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() {}
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        setGradient(ofView: self, startingByColor: .black, endingByColor: .white)
    }
    
    private func setGradient(ofView view: UIView?, startingByColor startColor: UIColor, endingByColor endColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.colors
            = [UIColor.black.withAlphaComponent(0.0).cgColor,
               UIColor.black.withAlphaComponent(0.5).cgColor,
               UIColor.black.withAlphaComponent(1.0).cgColor]
        
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.opacity = 0.3
        view?.layer.insertSublayer(gradientLayer, at: 0)
    }
}
