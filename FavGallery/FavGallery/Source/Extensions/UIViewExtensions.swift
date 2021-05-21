//
//  UIViewExtensions.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

extension UIView {
    
    func loadFromNib(_ name: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return nil }
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        return view
    }
}
