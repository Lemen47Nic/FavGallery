//
//  NetworkHandler.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation
import SystemConfiguration

struct NetworkHandler {
    
    static let shared = NetworkHandler()
    
    func fetch(url: String, successRange: Range<Int>?, completion: @escaping (AsyncCallResult<Data?, Any?>) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: url) else {
            completion(.failure(DataReponseError.invalidUrl))
            return nil
        }
        
        guard isInternetAvailable() else {
            completion(.failure(nil))
            return nil
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
        
        return task
    }
    
    func isInternetAvailable() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)

            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }

            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            return (isReachable && !needsConnection)
        }
}
