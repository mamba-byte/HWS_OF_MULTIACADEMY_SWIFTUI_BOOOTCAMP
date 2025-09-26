//
//  HW11App.swift
//  HW11
//
//  Created by İsmail Can Durak on 26.09.2025.
//

import SwiftUI

@main
struct HW11App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
