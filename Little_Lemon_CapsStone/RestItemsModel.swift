import Foundation
import CoreData


@MainActor
class DishesModel: ObservableObject {
    
    static let shared = DishesModel()
    
    @Published var menuItems = [MenuItem]()
    func reload(_ coreDataContext:NSManagedObjectContext) async  {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlSession = URLSession.shared
      
        let decoder = JSONDecoder()

        do {
            let (data, _) = try await urlSession.data(from: url)
            let menuResponse = try decoder.decode(MenuResponse.self, from: data)
            menuItems = menuResponse.menu
            RestItem
                .createDishesFrom(menuItems:menuItems, coreDataContext)
            for item in menuItems {
                print(
                    item
                )
            }
        } catch {
            print("Decoding failed with error: \(error)")
        }
    }

}
