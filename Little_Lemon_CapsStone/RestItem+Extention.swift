//
//  RestItem+Extention.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 17/05/25.
//
import Foundation
import CoreData



extension RestItem {
    static func createDishesFrom(menuItems: [MenuItem], _ context: NSManagedObjectContext) {
        for menuItem in menuItems {
//             Skip creation if the dish already exists
            if dishExists(name: menuItem.name, context: context) {
                continue
            }

            let oneDish = RestItem(context: context)
            oneDish.name = menuItem.name
            oneDish.price = menuItem.price
            oneDish.itemDescription = menuItem.description
            oneDish.image = menuItem.image
        }

        do {
            try context.save()
        } catch {
            print("Failed to save dishes to Core Data: \(error)")
        }
    }
    static func dishExists(name: String, context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<RestItem> = RestItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to check for existing dish: \(error.localizedDescription)")
            return false
        }
    }
    
}
