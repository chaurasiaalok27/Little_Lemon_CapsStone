//
//  RestItem+CoreDataProperties.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 17/05/25.
//
//

import Foundation
import CoreData


extension RestItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestItem> {
        return NSFetchRequest<RestItem>(entityName: "RestItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var itemDescription: String?
    @NSManaged public var image: String?

}

extension RestItem : Identifiable {

}
