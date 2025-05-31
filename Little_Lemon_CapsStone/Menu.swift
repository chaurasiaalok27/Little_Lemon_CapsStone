import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    //    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RestItem.name, ascending: true)], animation: .default)
    //    private var dishes: FetchedResults<RestItem>
    
    @State private var selectedCategory: String? = nil
    let categories = ["Starters", "Mains", "Desserts", "Sides"]
    
    @ObservedObject var dishesModel = DishesModel()
    
    @State var searchText = ""
    
    var body: some View {
        VStack() {
            ZStack{
                HStack( spacing: 10){
                    Spacer()
                    Image("littleLemonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.leading)
                    Spacer()
                }
                HStack( spacing: 10){
                    Spacer()
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
            }.padding(.horizontal)
                .frame(height: 60)
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Little Lemon")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex:"F4CE14"))
                        
                        Text("Chicago")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        
                        Text("We serve delicious Mediterranean food made with the freshest ingredients.").foregroundColor(.white)
                    }
                    
                    Image("topDish")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search...", text: $searchText)
                        .foregroundColor(.primary)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(6)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hex: "#495E57"))
            
            VStack(alignment: .leading, spacing: 16) {
                Text("ORDER FOR DELIVERY!")
                    .font(.title2)
                    .fontWeight(.black)
                
                HStack(spacing: 16) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Text(category)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(selectedCategory == category ? .white : .black)
                                .frame(width: 76, height: 30)
                                .background(
                                    selectedCategory == category
                                    ? Color(hex: "#495E57")
                                    : Color(hex: "#EDEFEE")
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding()
            
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
                                            .font(.system(size: 12))
                                        if let priceString = item.price, let price = Double(priceString) {
                                            Text(String(format: "$%.2f", price))
                                        } else {
                                            Text("$0.00")
                                        }
                                        
                                    }
                                    Spacer()
                                    
                                    
                                    if let imageUrlString = item.image, let imageUrl = URL(string: imageUrlString) {
                                        AsyncImage(url: imageUrl) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            case .failure:
                                                Image("dishImage")
                                                    .resizable()
                                                    .scaledToFill()
                                            @unknown default:
                                                Image("dishImage")
                                                    .resizable()
                                                    .scaledToFill()
                                                
                                            }
                                        }
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    } else {
                                        Image("dishImage")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                    
                                }
                                .padding(.vertical, 8) // Optional: tighter row spacing
                            }
                        }
                        .listStyle(PlainListStyle()) // remove extra insets from List
                        //                        .searchable(text: $searchText,
                        //                                    prompt: "search...")
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
