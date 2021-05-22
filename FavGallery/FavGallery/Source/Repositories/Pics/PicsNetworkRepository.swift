//
//  PicsNetworkRepository.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

class PicsNetworkRepository: PicsRepository {
    
    var currentTask: URLSessionDataTask?
    
    func get(by filter: String, completion: @escaping (AsyncCallResult<[Pic]?, Any?>) -> Void) {
        
        let url = FavGalleryURL.get(filter: filter).url
        
        if currentTask != nil {
            currentTask?.cancel()
        }
        
        currentTask = NetworkHandler.shared.fetch(url: url, successRange: Range(200...201)) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.managePics(data: data, completion)
            case .failure(let msg):
                print("Error calling PicsNetworkRepository.get: \(String(describing: msg))")
            }
        }
    }
}

extension PicsNetworkRepository {
    
    private func managePics(data: Data?, _ completion: @escaping (_ result: AsyncCallResult<[Pic]?, Any?>) -> Void) {
        
        guard let data = data,
              let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
              let subData = json["data"] as? [String:Any],
              let children = subData["children"] as? [[String:Any]]
        else {
            completion(.success([]))
            return
        }
        
        let childrenSubData = (children.compactMap{ $0["data"] as? [String:Any] })
        let pics: [Pic] = childrenSubData.compactMap{
            var pic = PicModel()
            pic.fill(with: $0)
            return pic
        }
        
        completion(.success(pics))
    }
}
