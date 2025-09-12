//
//  ContentView.swift
//  HW8
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var noteManager = NoteManager()
    @State private var showingAddNote = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(noteManager.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note, noteManager: noteManager)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(note.title)
                                .font(.headline)
                                .lineLimit(1)
                            
                            Text(note.content)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                            
                            Text(note.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 2)
                    }
                }
                .onDelete(perform: noteManager.deleteNote)
            }
            .navigationTitle("Notlarım")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddNote = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteView(noteManager: noteManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
