//
//  DBService.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/21/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation
import CoreData

class DBService {
    
    static let instance = DBService()
    
    private init() {}
    
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PopMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error! Smth's wrong with entity saving!")
            }
        }
    }
    
    func findFilms() -> [Movie] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as! [Movie]
            return result.sorted(by: { $0.popularity > $1.popularity })
        } catch {
            print("Error! Smth's wrong with entity finding!")
        }
        return []
    }
    
    func deleteAll() {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for object in result {
                let managedObjectData:NSManagedObject = object as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch {
            print("Error! Smth's wrong with entity deleting!")
        }
    }
}
