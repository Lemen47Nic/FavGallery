//
//  PicsRepository.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

protocol PicsRepository {
    
    func get(by filter: String, completion: @escaping (_ result: AsyncCallResult<[Pic]?, Any?>) -> Void)
    
    func save(_ pics: [Pic])
}
