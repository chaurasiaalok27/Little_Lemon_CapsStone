import Foundation
import CoreData


@MainActor
class DishesModel {
    
    static let shared = DishesModel()
    
    @Published var menuItems = [MenuItem]()
    func reload(_ coreDataContext:NSManagedObjectContext) {
        let jsonString = """
        {
          "menu": [
            {
              "name": "Greek Salad",
              "price": 12.99,
              "description": "Our delicious salad is served with Feta cheese and peeled cucumber. Includes tomatoes, onions, olives, salt and oregano in the ingredients.",
              "image": "dishImage.jpg"
            },
            {
              "name": "Bruschetta",
              "price": 7.99,
              "description": "Delicious grilled bread rubbed with garlic and topped with olive oil and salt. Our Bruschetta includes tomato and cheese.",
              "image": "dishImage.jpg"
            },
            {
              "name": "Grilled Fish",
              "price": 20.00,
              "description": "Fantastic grilled fish seasoned with salt.",
              "image": "dishImage.jpg"
            }
          ]
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Failed to convert string to data.")
            return
        }

        let decoder = JSONDecoder()

        do {
            let menuResponse = try decoder.decode(MenuResponse.self, from: jsonData)
            menuItems = menuResponse.menu
            RestItem
                .createDishesFrom(menuItems:menuItems, coreDataContext)
            for item in menuResponse.menu {
                print(
                    "🍽️ Name: \(item.name)\n💰 Price: \(item.price)\n📄 Description: \(item.description)\n🖼️ Image: \(item.image)\n"
                )
            }
        } catch {
            print("Decoding failed with error: \(error)")
        }
    }

}
