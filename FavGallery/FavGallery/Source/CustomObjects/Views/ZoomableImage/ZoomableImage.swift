//
//  ZoomableImage.swift
//  FavGallery
//
//  Created by naspes on 22/05/21.
//

import UIKit

class ZoomableImage: UIView, UIScrollViewDelegate {

    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var imageView: UIImageView!
    
    private var gestureRecognizer: UITapGestureRecognizer?
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var link: String? {
        didSet {
            guard let link = link else { return }
            imageView.image(from: link)
        }
    }
    
    var zoomScale: CGFloat = 1 {
        didSet {
            scrollView.setZoomScale(zoomScale, animated: true)
        }
    }
    
    // called when built from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadFromNib("ZoomableImage") else { return }
        self.addSubview(view)
        setup()
    }
    
    // called when built from xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadFromNib("ZoomableImage") else { return }
        self.addSubview(view)
    }
    
    // like a viewDidLoad when built from xib
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
        // setup zoom
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.zoomScale = 1.0
        scrollView.delegate = self
        
        // setup double tap
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer?.numberOfTapsRequired = 2
        guard let gestureRecognizer = gestureRecognizer else { return }
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleDoubleTap() {
        guard let gestureRecognizer = gestureRecognizer else { return }
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(2, center: gestureRecognizer.location(in: gestureRecognizer.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    // Calculates the zoom rectangle for the scale
    private func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        let newCenter = convert(center, from: imageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
