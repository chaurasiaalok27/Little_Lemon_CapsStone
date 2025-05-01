//
//  ContentView.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 01/05/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
