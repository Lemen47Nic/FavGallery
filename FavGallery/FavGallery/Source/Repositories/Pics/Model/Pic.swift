//
//  Pic.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

protocol Pic {
    var title: String? { get set }
    var author: String? { get set }
    var thumbnailUrl: String? { get set }
    var url: String? { get set }
    
    mutating func fill(with data: [String: Any])
}

extension Pic {
    
    mutating func fill(with data: [String: Any]) {
        self.title = data["title"] as? String ?? ""
        self.author = data["author"] as? String ?? ""
        self.thumbnailUrl = data["thumbnail"] as? String ?? ""
        self.url = data["url"] as? String ?? ""
    }
}
