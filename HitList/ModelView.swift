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
    
    func save(id: NSNumber, name: String, lat: Double, lon: Double, image1: Data, image2: Data, image3: Data){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        let entity = NSEntityDescription.entity(forEntityName: "PersonEntity", in: context)
        let newNote = PersonEntity(entity: entity!, insertInto: context)
        newNote.id = id //personList.count as NSNumber
        newNote.name = name //nameText.text
        newNote.lat = lat //Double(latText.text!)!
        newNote.lon = lon  //Double(longText.text!)!
        newNote.image1 = image1//(imageView1.image?.pngData()!)
        newNote.image2 = image2//(imageView2.image?.pngData()!)
        newNote.image3 = image3//(imageView3.image?.pngData()!)
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

