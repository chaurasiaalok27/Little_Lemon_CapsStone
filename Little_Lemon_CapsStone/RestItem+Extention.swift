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
            if dishExists(name: menuItem.title, context: context) {
                continue
            }

            let oneDish = RestItem(context: context)
            oneDish.name = menuItem.title
            oneDish.price = menuItem.price
            oneDish.itemDescription = menuItem.description
            oneDish.image = menuItem.image
            oneDish.category = menuItem.category
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
