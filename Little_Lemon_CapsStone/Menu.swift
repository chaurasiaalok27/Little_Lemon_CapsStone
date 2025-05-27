import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RestItem.name, ascending: true)], animation: .default)
//    private var dishes: FetchedResults<RestItem>
    
    @ObservedObject var dishesModel = DishesModel()
    
    @State var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Little Lemon")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Chicago")
                    .font(.title2)
                    .foregroundColor(.gray)

                Text("We serve delicious Mediterranean food made with the freshest ingredients.")
            }
            .padding([.horizontal, .top]) // only pad the header

            NavigationView {
                
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [RestItem]) in
                        List {
                            ForEach(dishes,id:\.self) { item in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.name ?? "Unknown Dish")
                                            .font(.headline)
                                        Text(item.itemDescription ?? "Unknown Description")
                                            .font(.system(size: 8))
                                        Text(item.price ?? "0")
                                    }
                                    Spacer()
                                    Image("dishImage")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                .padding(.vertical, 8) // Optional: tighter row spacing
                            }
                        }
                        .listStyle(PlainListStyle()) // remove extra insets from List
                        .searchable(text: $searchText,
                                    prompt: "search...")
                    }
            }
        }
        .task {
          await  dishesModel.reload(viewContext)
        }
        
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText == ""
        {
            return NSPredicate(value: true)
        }
        else{
            return NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        }
 
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(keyPath: \RestItem.name, ascending: true)]
    }
}
