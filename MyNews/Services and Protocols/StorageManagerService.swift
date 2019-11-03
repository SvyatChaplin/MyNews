//
//  StorageManagerService.swift
//  MyNews
//
//  Created by Svyat Chaplin on 03.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation
import CoreData

class StorageManagerService {

    func saveNewsData(_ data: Results) {
        let appDelegate = AppDelegate()
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "SavedNewsData", in: context) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context) as! SavedNewsData
        managedObject.abstract = data.abstract
        managedObject.title = data.title
        managedObject.url = data.url

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func getData() -> [SavedNewsData]? {
        let appDelegate = AppDelegate()
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedNewsData> = SavedNewsData.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func removeObject(at index: Int) {
        print(index)
        let appDelegate = AppDelegate()
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedNewsData> = SavedNewsData.fetchRequest()
        let results = try? context.fetch(fetchRequest)
        let resultsData = results as! [NSManagedObject]
        context.delete(resultsData[index])
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}
