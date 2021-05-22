//
//  LocalImagesHandler.swift
//  FavGallery
//
//  Created by naspes on 22/05/21.
//

import UIKit

protocol LocalImagesHandlerProtocol: LocalFilesHandlerProtocol where file_T == UIImage {
    var stashedImages: [UIImage?]? {get set}
    var stashedCoverIndex: Int? {get set}

    func saveImageToGallery(currentImage: UIImage)
}

extension LocalImagesHandlerProtocol {
    
    func saveFileInDocumentDirectory(nameOfDirectory: String, fileName: String, file: file_T) {
        let url = getDirectoryUrl(nameOfDirectory: nameOfDirectory)
        let imagePath = url?.appendingPathComponent(fileName)
        let urlString: String = imagePath!.absoluteString
        let imageData = file.jpegData(compressionQuality: 1.0)
        //let imageData = UIImagePNGRepresentation(image)
        FileManager.default.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
    }
    
    
    func getFilesFromDocumentDirectory(nameOfDirectory: String) -> [file_T?] {
        guard let imagesURL = getFileUrlsFromDocumentDirectory(nameOfDirectory: nameOfDirectory) else { return [] }
        
        let nImages = imagesURL.count
        var imageArray:[UIImage?] = []
        
        for i in 0 ..< nImages {
            let urlString: String = imagesURL[i].path
            if FileManager.default.fileExists(atPath: urlString) {
                let image = UIImage(contentsOfFile: urlString)
                imageArray.append(image)
            }
        }
        
        return imageArray
    }
}

protocol LocalImagesHandlerDelegate: AnyObject {
    func saveImageCompletion(image: UIImage, error: Error?, contextInfo: UnsafeMutableRawPointer)
}

class LocalImagesHandler: NSObject, LocalImagesHandlerProtocol {

    public static var sharedInstance = LocalImagesHandler()
    
    weak var delegate: LocalImagesHandlerDelegate?
    
    var stashedImages: [UIImage?]?
    var stashedCoverIndex: Int?
    
    func saveImageToGallery(currentImage: UIImage) {
        UIImageWriteToSavedPhotosAlbum(currentImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer) {
        delegate?.saveImageCompletion(image: image, error: error, contextInfo: contextInfo)
    }
}
