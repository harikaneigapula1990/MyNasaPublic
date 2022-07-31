//
//  CoreDataSharedManager.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 31/07/22.
//

import Foundation
import UIKit

import CoreData

class CoreDataSharedManager {
    static let shared = CoreDataSharedManager()
    
    private init() {
        
    }
    
    func deleteData(url: String) {
        guard checkIfItemExist(type: url) else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavPictureEntity")
        fetchRequest.predicate = NSPredicate(format: "picture = %@",url)
        
        do {
            let fetch = try managedObjectContext.fetch(fetchRequest)
            let objectToDelete = fetch[0] as! NSManagedObject
            managedObjectContext.delete(objectToDelete)
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print(error.userInfo)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func saveData(url: String) {
        guard !checkIfItemExist(type: url) else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let favPictureEnitity = NSEntityDescription.entity(forEntityName: "FavPictureEntity", in: managedObjectContext)!
        
        let entity = NSManagedObject(entity: favPictureEnitity, insertInto: managedObjectContext)
        entity.setValue(url, forKey: "picture")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print(error.userInfo)
        }
        
    }
    
    func retriveData() -> [String] {
        var myFavList = [String]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return myFavList}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavPictureEntity")
        
        do {
            let fetch = try managedObjectContext.fetch(fetchRequest)
            for data in fetch as! [NSManagedObject] {
                myFavList.append(data.value(forKey: "picture") as! String)
            }
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print(error.userInfo)
            }
        } catch {
            print(error.localizedDescription)
        }
        return myFavList
    }
    
    func checkIfItemExist(type: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavPictureEntity")

        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "picture == %@" ,type)

        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
}
