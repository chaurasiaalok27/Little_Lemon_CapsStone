//
//  ContentView.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 01/05/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \RestItem.name, ascending: true)],animation: .default)
    
    
    private var dishes: FetchedResults<RestItem>
    var body: some View {
        NavigationView {
            VStack{
               
                List{
                    ForEach(dishes) { item in
                        HStack(){
                            VStack(alignment: .leading,spacing: 4) {
                                Text(item.name ?? "Unknown Dish") // Safely unwrap
                                    .font(.headline)
                                Text(
                                    item.itemDescription ?? "Unknown Size"
                                ).font(.system(size: 8))
                                Text("$\(item.price, specifier: "%.2f")")
                            }
                            Spacer()
                            Image("dishImage")
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: 100,
                                    height: 100,
                                    alignment: .center
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.all,8)
                            
                        }
                    }
                }
                
                
            }
        }.onAppear {
            if dishes.isEmpty {
                DishesModel.shared.reload(viewContext)
            }
        }
    }
    
    func createMenu() {
        let dessert = RestItem(context: viewContext)
        dessert.name = "Profiterole"
        dessert.itemDescription = "Large"
        dessert.price = 2.99
        
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
