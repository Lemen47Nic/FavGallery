//
//  PicsService.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

struct PicsService {
    
    let picsPersistentRepository = PicsPersistentRepository()
    let picsNetworkRepository = PicsNetworkRepository()
    
    func get(by filter: String, completion: @escaping (_ result: [Pic]?) -> Void) {
        
        picsPersistentRepository.get(by: filter) { (persistenResult) in
            
            if case .success(let pics) = persistenResult,
               pics?.count ?? 0 > 0 {
                completion(pics)
                return
            }
            
            picsNetworkRepository.get(by: filter) { (networkResult) in
                if case .success(let pics) = networkResult {
                    
                    if let pics = pics {
                        picsPersistentRepository.save(pics)
                    }
                    
                    completion(pics)
                } else {
                    completion([])
                }
            }
        }
    }
}
