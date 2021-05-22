//
//  LocalFilesHandler.swift
//  FavGallery
//
//  Created by naspes on 22/05/21.
//

import Foundation

protocol LocalFilesHandlerProtocol {
    
    associatedtype file_T
    
    func getDirectoryUrl(nameOfDirectory: String) -> URL?
    func saveFileInDocumentDirectory(nameOfDirectory: String, fileName: String, file: file_T)
    func getFileUrlsFromDocumentDirectory(nameOfDirectory: String) -> [URL]?
    func directoryIsNotEmpty(nameOfDirectory: String) -> Bool
    func fileExistWith(name: String, nameOfDirectory: String) -> Bool
    func fileExistAt(url: String, nameOfDirectory: String) -> Bool
    func getFilesFromDocumentDirectory(nameOfDirectory: String) -> [file_T?]
    func getUrlOfFileAt(index: Int, nameOfDirectory: String) -> String?
    func getUrlOfFile(nameOfDirectory: String, fileName: String) -> String?
    func getNameOfFileAt(index: Int, nameOfDirectory: String) -> String?
    func deleteFileAt(url: String)
    func deleteAllFilesIn(nameOfDirectory: String)
    func numberOfFilesInDocumentDirectory(nameOfDirectory: String) -> Int?
    func listOfFilesInDocumentDirectory(nameOfDirectory: String) -> [String?]?
}

extension LocalFilesHandlerProtocol {
    
    func getDirectoryUrl(nameOfDirectory: String) -> URL? {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nameOfDirectory)
        if !FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        return URL(string: path)
    }
    
    func getFileUrlsFromDocumentDirectory(nameOfDirectory: String) -> [URL]? {
        guard let url = getDirectoryUrl(nameOfDirectory: nameOfDirectory) else { return [] }
        return try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [], options:  [.skipsHiddenFiles, .skipsSubdirectoryDescendants]).sorted(by: {$0.path < $1.path})
    }
    
    func directoryIsNotEmpty(nameOfDirectory: String) -> Bool {
        guard let filesURL = getFileUrlsFromDocumentDirectory(nameOfDirectory: nameOfDirectory) else { return false }
        return filesURL.count > 0
    }
    
    func fileExistWith(name: String, nameOfDirectory: String) -> Bool {
        guard let filesURL = getFileUrlsFromDocumentDirectory(nameOfDirectory: nameOfDirectory) else { return false }
        let filesName = filesURL.map{String($0.path.split(separator: "/").last ?? "")}
        return filesName.contains(name)
    }
    
    func fileExistAt(url: String, nameOfDirectory: String) -> Bool {
        guard let filesURL = getFileUrlsFromDocumentDirectory(nameOfDirectory: nameOfDirectory) else { return false }
        return filesURL.map{$0.path}.contains(url)
    }
    
    func getUrlOfFileAt(index: Int, nameOfDirectory: String) -> String? {
        guard let filesURL = getFileUrlsFromDocumentDirectory(nameOfDirectory: nameOfDirectory) else { return nil }
        if filesURL.count > index {
            return filesURL[index].path
        }
        return nil
    }
    
    func getUrlOfFile(nameOfDirectory: String, fileName: String) -> String? {
        guard let filesURL = getFileUrlsFromDocumentDirectory(nameOfDirectory: nameOfDirectory) else { return nil }
        return (filesURL.first { $0.lastPathComponent == fileName })?.path
    }
    
    func getNameOfFileAt(index: Int, nameOfDirectory: String) -> String? {
        guard let fileName = getUrlOfFileAt(index: index, nameOfDirectory: nameOfDirectory)?.split(separator: "/").last else { return nil }
        return String(fileName)
    }
    
    func deleteFileAt(url: String) {
        try? FileManager.default.removeItem(atPath: url)
    }
    
    func deleteAllFilesIn(nameOfDirectory: String) {
        guard let url = getDirectoryUrl(nameOfDirectory: nameOfDirectory) else { return }
        try? FileManager.default.removeItem(atPath: url.path)
    }
    
    func numberOfFilesInDocumentDirectory(nameOfDirectory: String) -> Int? {
        return getFilesFromDocumentDirectory(nameOfDirectory: nameOfDirectory).count
    }
    
    func listOfFilesInDocumentDirectory(nameOfDirectory: String) -> [String?]? {
        let files = getFilesFromDocumentDirectory(nameOfDirectory: nameOfDirectory)
        var result: [String?] = []
        for i in 0 ..< files.count {
            result.append(getNameOfFileAt(index: i, nameOfDirectory: nameOfDirectory))
        }
        return result
    }
}
