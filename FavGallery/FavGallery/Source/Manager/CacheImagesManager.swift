//
//  CacheImagesService.swift
//  FavGallery
//
//  Created by naspes on 22/05/21.
//

import UIKit

struct CacheImagesManager {
    
    let directory = "FavGalleryDirectory"
    
    func getUIImage(from link: String, completion: @escaping (_ image: UIImage?) -> Void) {
        guard let url = URL(string: link) else { return }
        
        getUIImageFromDirectory(url: url) { (image) in
            if let image = image {
                completion(image)
                return
            }
            
            getUIImageFromRemote(url: url) { (image) in
                saveUIImageInDirectory(url: url, image: image)
                completion(image)
            }
        }
    }
    
    private func getUIImageFromDirectory(url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        let name = url.lastPathComponent
        let localImagePath = LocalImagesHandler.shared.getUrlOfFile(nameOfDirectory: directory, fileName: name)
        
        guard let path = localImagePath else {
            completion(nil)
            return
        }
        completion(UIImage(contentsOfFile: path))
    }
    
    private func getUIImageFromRemote(url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        
        let imageView = UIImageView()
        imageView.image(from: url) {
            DispatchQueue.main.async {
                guard let image = imageView.image else { return }
                completion(image)
            }
        }
    }
    
    private func saveUIImageInDirectory(url: URL, image: UIImage?) {
        guard let image = image else { return }
        let name = url.lastPathComponent
        LocalImagesHandler.shared.saveFileInDocumentDirectory(nameOfDirectory: directory, fileName: name, file: image)
    }
}
