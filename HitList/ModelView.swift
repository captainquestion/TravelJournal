//
//  ModelView.swift
//  HitList
//
//  Created by canberk yılmaz on 2022-09-09.
//

import Foundation
import CoreData
import UIKit

class ModelView {
    
    var firstLoad = true
    
    // function returns an array of PersonEntities in personList array if the record doesnt have a deletedData value
    func nonDeletedNotes() -> [PersonEntity]
    {
        var noDeleteNoteList = [PersonEntity]()
        for person in personList
        {
            if(person.deletedDate == nil)
            {
                noDeleteNoteList.append(person)
            }
        }
        return noDeleteNoteList
    }
    
    
    //creating NSManagedObjectContext for persistentContainer and fetch request to fetching inputs from PersonEntity DB and appending the values into personList array
    func fetchData(){
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonEntity")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let person = result as! PersonEntity
                    personList.append(person)
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    
    //Stamping the entries within the PersonEntityDB with deletedData value for not including in the list.
    func delete(indexPathRow: Int) {
        let selectedPerson : PersonEntity!
        selectedPerson = nonDeletedNotes()[indexPathRow]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonEntity")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let person = result as! PersonEntity
                if(person == selectedPerson)
                {
                    
                    person.deletedDate = Date()
                    
                    try context.save()
                    
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
    
    //saving data to the database and personList array with respect to given parameters.
    func save(id: NSNumber, name: String, lat: Double, lon: Double, image1: Data, image2: Data, image3: Data){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        let entity = NSEntityDescription.entity(forEntityName: "PersonEntity", in: context)
        let newNote = PersonEntity(entity: entity!, insertInto: context)
        newNote.id = id 
        newNote.name = name
        newNote.lat = lat
        newNote.lon = lon
        newNote.image1 = image1
        newNote.image2 = image2
        newNote.image3 = image3
        do
        {
            try context.save()
            personList.append(newNote)
            
        }
        catch
        {
            print("context save error")
        }
        
    }
}

