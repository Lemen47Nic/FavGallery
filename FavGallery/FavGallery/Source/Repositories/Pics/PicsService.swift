//
//  PicsService.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

struct PicsService {
    
    func get(by filter: String, completion: @escaping (_ result: [Pic]?) -> Void) {
        PicsNetworkRepository.get(by: filter) { (result) in
            if case .success(let pics) = result {
                completion(pics)
            } else {
                completion([])
            }
        }
    }
}
