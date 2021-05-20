//
//  NetworkHandler.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

struct NetworkHandler {
    
    static let shared = NetworkHandler()
    
    func fetch(url: String, successRange: Range<Int>?, completion: @escaping (AsyncCallResult<Data?, Any?>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(DataReponseError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                completion(.failure(DataReponseError.error(msg: "\(error)")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if let successRange = successRange,
               !(successRange.contains(httpResponse.statusCode)) {
                completion(.failure(DataReponseError.invalidStatusCode(msg: "\(String(describing: response))")))
                return
            }
            
            completion(.success(data))
        })
        task.resume()
    }
    
}
