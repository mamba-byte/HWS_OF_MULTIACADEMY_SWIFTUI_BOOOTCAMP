//
//  HW9App.swift
//  HW9
//
//  Created by İsmail Can Durak on 20.09.2025.
//

import SwiftUI

@main
struct HW9App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
