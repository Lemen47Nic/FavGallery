//
//  URL.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

enum FavGalleryURL {
    
    case get(filter: String)
    
    var url: String {
        var baseUrl = "https://www.reddit.com/"
        
        switch self {
        case .get(let filter):
            return "\(baseUrl)r/\(filter)/top.json"
        }
    }
}
