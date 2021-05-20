//
//  AsyncCallResult.swift
//  FavGallery
//
//  Created by naspes on 20/05/21.
//

import Foundation

public enum AsyncCallResult<S, F> {
    case success(S)
    case failure(F)
    
    var value: S? {
        switch self {
        case .success(let v):
            return v
        case .failure:
            return nil
        }
    }
}

enum DataReponseError: Error {
    case invalidUrl
    case error(msg: String?)
    case invalidStatusCode(msg: String?)
    case invalidDictionary
}
