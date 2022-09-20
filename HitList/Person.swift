//
//  Person.swift
//  HitList
//
//  Created by canberk yılmaz on 2022-09-14.
//

import CoreData

//Creating manuel NSManagedObject to be used in CoreData infastructure

@objc(PersonEntity)
class PersonEntity: NSManagedObject{
    @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var deletedDate: Date!
    @NSManaged var image1: Data!
    @NSManaged var image2: Data!
    @NSManaged var image3: Data!
    @NSManaged var lat: Double
    @NSManaged var lon: Double


    
}
