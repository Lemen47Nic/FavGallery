//
//  PicsRepository.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

protocol PicsRepository {
    
    static func get(by filter: String?, completion: @escaping (_ result: [Pic]?) -> Void)
}
