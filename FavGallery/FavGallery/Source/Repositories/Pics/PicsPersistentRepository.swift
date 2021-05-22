//
//  PicsPersistenRepository.swift
//  FavGallery
//
//  Created by naspes on 22/05/21.
//

import UIKit
import CoreData

class PicsPersistentRepository: PicsRepository {
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext  {
        appDelegate.persistentContainer.viewContext
    }
    
    func get(by filter: String, completion: @escaping (AsyncCallResult<[Pic]?, Any?>) -> Void) {
        
        let picFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PicEntity")
        picFetch.predicate = NSPredicate(format: "filter == %@", filter)
        
        do {
            let pics = try context.fetch(picFetch) as! [PicEntity]
            completion(.success(pics))
        } catch {
            completion(.failure(nil))
        }
    }
    
    func save(_ pics: [Pic]) {
        for pic in pics {
            var picEntity = NSEntityDescription.insertNewObject(forEntityName: "PicEntity", into: context) as! PicEntity
            picEntity.fill(with: pic)
        }
        
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }

    }
}
