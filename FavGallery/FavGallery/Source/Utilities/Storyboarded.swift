//
//  Storyboarded.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation
import UIKit

protocol Storyboarded where Self: UIViewController {
    static var identifier: StoryboardIdentifier { get set }
    static var storyboard: UIStoryboard { get }
    static func instantiate() -> Self
}

extension Storyboarded {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: identifier.rawValue, bundle: nil)
    }
    
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        return self.storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

enum StoryboardIdentifier: String {
    case main = "Main"
}
