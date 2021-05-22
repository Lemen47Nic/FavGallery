//
//  UIImageExtensions.swift
//  FavGallery
//
//  Created by naspes on 21/05/21.
//

import UIKit

extension UIImageView {
    
    func image(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: (() -> Void)? = nil) {
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType,
                  mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
            
            guard let completion = completion else { return }
            completion()
        }.resume()
    }
    
    func image(from link: String, contentMode mode: ContentMode = .scaleAspectFit, completion: (() -> Void)? = nil) {
        guard let url = URL(string: link) else { return }
        image(from: url, contentMode: mode, completion: completion)
    }
}
