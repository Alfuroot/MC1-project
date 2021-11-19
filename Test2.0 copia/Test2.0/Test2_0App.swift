//
//  Test2_0App.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 16/11/21.
//

import SwiftUI

@main
struct Test2_0App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
