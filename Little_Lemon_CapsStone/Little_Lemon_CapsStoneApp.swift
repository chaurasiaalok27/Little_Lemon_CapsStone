//
//  Little_Lemon_CapsStoneApp.swift
//  Little_Lemon_CapsStone
//
//  Created by alok chaurasia on 01/05/25.
//

import SwiftUI

@main
struct Little_Lemon_CapsStoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
