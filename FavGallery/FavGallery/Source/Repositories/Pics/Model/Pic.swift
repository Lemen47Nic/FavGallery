//
//  Pic.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

protocol Pic {
    var filter: String? { get set }
    var title: String? { get set }
    var author: String? { get set }
    var thumbnailUrl: String? { get set }
    var url: String? { get set }
    
    mutating func fill(with data: [String: Any], filter: String)
    mutating func fill(with data: Pic)
}

extension Pic {
    
    mutating func fill(with data: [String: Any], filter: String) {
        self.filter = filter
        self.title = data["title"] as? String ?? ""
        self.author = data["author"] as? String ?? ""
        self.thumbnailUrl = data["thumbnail"] as? String ?? ""
        self.url = data["url"] as? String ?? ""
    }
    
    mutating func fill(with pic: Pic) {
        self.filter = pic.filter
        self.title = pic.title
        self.author = pic.author
        self.thumbnailUrl = pic.thumbnailUrl
        self.url = pic.url
    }
}
