//
//  DetailItem.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 01/06/25.
//


//
//  DetailItem.swift
//  littlelemon
//
//  Created by Maulik shah on 31.05.2025.
//

import SwiftUI

struct DetailItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dish: RestItem
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .clipShape(Rectangle())
            .frame(minHeight: 150)
            Text(dish.name ?? "")
                .font(.headline)
                .foregroundColor(Color(hex: "#495E57"))
            Spacer(minLength: 20)
            Text(dish.itemDescription ?? "")
                .font(.system(size: 12))
            Spacer(minLength: 10)
            Text("$" + (dish.price ?? ""))
                .font(.system(size: 16))
                .foregroundColor(Color(hex: "#495E57"))
                .monospaced()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(dish: PersistenceController.oneDish())
    }
}
