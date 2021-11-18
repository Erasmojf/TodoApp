//
//  Todo_AppApp.swift
//  Todo App
//
//  Created by Erasmo J.F Da Silva on 18/11/21.
//

import SwiftUI

@main
struct Todo_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
