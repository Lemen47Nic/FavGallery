//
//  AlertView.swift
//  FavGallery
//
//  Created by naspes on 22/05/21.
//

import UIKit

class AlertView: UIView {
    
    // called when built from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let view = loadFromNib("AlertView") else { return }
        self.addSubview(view)
        setup()
    }
    
    // called when built from xib
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadFromNib("AlertView") else { return }
        self.addSubview(view)
    }
    
    // like a viewDidLoad when built from xib
    override func awakeFromNib() {
        setup()
    }
    
    private func setup() { }
}
