//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Technoexponent on 20/09/19.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var contactNo: String?
    @NSManaged public var eventDetails: String?
    @NSManaged public var eventName: String?
    @NSManaged public var id: String?

}
