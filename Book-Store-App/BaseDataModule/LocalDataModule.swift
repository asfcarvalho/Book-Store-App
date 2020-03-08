//
//  LocalDataModule.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 07/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import UIKit
import CoreData

class LocalDataModule {
    
    static let share = LocalDataModule()
    
    func createData(_ myBook: MyBook?, callBack: (String?) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            callBack("Could not save.")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            
            let userEntity = NSEntityDescription.entity(forEntityName: "MyFavoriteBook", in: managedContext)!
            
            let favoriteBooks = NSManagedObject(entity: userEntity, insertInto: managedContext)
            favoriteBooks.setValue(myBook?.id, forKey: "id")
            favoriteBooks.setValue(myBook?.title, forKey: "title")
            favoriteBooks.setValue(myBook?.authors, forKey: "authors")
            favoriteBooks.setValue(myBook?.buyLink, forKey: "buyLink")
            favoriteBooks.setValue(myBook?.imageLink, forKey: "imageLink")
            favoriteBooks.setValue(myBook?.description, forKey: "descriptionBook")
            
            try managedContext.save()
            
            callBack(nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            callBack(error.localizedDescription)
        }
    }
    
    func fetchData(_ id: String, callBack: ([MyFavoriteBook]?) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            callBack(nil)
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyFavoriteBook")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            callBack(result as? [MyFavoriteBook])
        } catch {
            print("Failed")
            callBack(nil)
        }
    }
    
    func fetchAllData(callBack: ([MyFavoriteBook]?) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            callBack(nil)
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyFavoriteBook")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            callBack(result as? [MyFavoriteBook])
        } catch {
            print("Failed")
            callBack(nil)
        }
    }
    
    func deleteData(_ id: String, callBack: (String?) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            callBack("Error to remove")
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyFavoriteBook")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
       
        do
        {
            let remove = try managedContext.fetch(fetchRequest)
            
            remove.forEach { managedContext.delete($0 as! NSManagedObject) }
            
            try managedContext.save()
            callBack(nil)
        }
        catch
        {
            print(error)
            callBack(error.localizedDescription)
        }
    }
}
