//
//  ContentView.swift
//  HW9
//
//  Created by İsmail Can Durak on 20.09.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NotesListView()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
