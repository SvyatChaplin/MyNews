//
//  StorageManagerService.swift
//  MyNews
//
//  Created by Svyat Chaplin on 03.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation
import CoreData

class StorageManagerService: StorageManager {
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyNews")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Methods to manage data
    
    func saveNewsData(_ data: Articles) {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "SavedNewsData", in: context) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context) as! SavedNewsData
        managedObject.abstract = data.description
        managedObject.title = data.title
        managedObject.url = data.url
        managedObject.urlToImage = data.urlToImage
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getData() -> [Articles]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedNewsData> = SavedNewsData.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            return results.map(Articles.init)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func removeObject(at index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedNewsData> = SavedNewsData.fetchRequest()
        guard let results = try? context.fetch(fetchRequest) else { return }
        context.delete(results[index])
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

extension Articles {

    init(savedNewsData: SavedNewsData) {
        self.description = savedNewsData.abstract
        self.title = savedNewsData.title
        self.url = savedNewsData.url
        self.urlToImage = savedNewsData.urlToImage
    }
}
