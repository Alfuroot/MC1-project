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
            if(UserDefaults.standard.bool(forKey: "LaunchBefore")){
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }else{
                Onboarding()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
         
        }
    }
}
