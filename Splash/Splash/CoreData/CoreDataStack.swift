//
//   CoreDataStack.swift
//   Splash
//
//  Created by: CSC214 Instructor on 10/24/19.
//  Copyright © 2019 University of Rochester. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack: NSObject {
    
    static let shared = CoreDataStack()
    
    let modelName = "Splash"
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Splash")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var items: [NSManagedObject] = []
    
    // MARK: - Core Data operations
    
    func update() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Fish")
        do {
            items = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch requested entity. \(error), \(error.userInfo)")
        }
    }
    
    func saveItem(name: String, dateCaught: Date) {
        if let entity = NSEntityDescription.entity(forEntityName: "Fish", in: context) {
            let item = NSManagedObject(entity: entity, insertInto: context)
            item.setValue(name, forKeyPath: "name")
            item.setValue(dateCaught, forKeyPath: "dateCaught")
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save the entity. \(error), \(error.userInfo)")
            }
        }
        update()
    }
    
    func deleteItem(name: NSManagedObject) {
        if let _ = items.firstIndex(of: name)  {
            context.delete(name)
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not delete the item. \(error), \(error.userInfo)")
            }
        }
        update()
    }
    
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
    
}


