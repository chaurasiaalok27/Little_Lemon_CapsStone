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
    @State var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")

    var body: some Scene {
        WindowGroup {
            OnBoarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
