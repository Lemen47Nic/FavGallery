//
//  Pic.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

protocol Pic: Codable {
    var title: String { get set }
    var author: String { get set }
    var thumbnailUrl: String { get set }
    var url: String { get set }
}
