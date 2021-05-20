//
//  PicModel.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

struct PicModel: Pic {
    var title: String
    var author: String
    var thumbnailUrl: String
    var url: String
    
    init() {
        title = ""
        author = ""
        thumbnailUrl = ""
        url = ""
    }
}

