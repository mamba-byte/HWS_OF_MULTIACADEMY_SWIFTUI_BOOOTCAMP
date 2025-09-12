//
//  NoteManager.swift
//  HW8
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import Foundation

class NoteManager: ObservableObject {
    @Published var notes: [Note] = []
    
    private let userDefaults = UserDefaults.standard
    private let notesKey = "SavedNotes"
    
    init() {
        loadNotes()
    }
    
    func addNote(_ note: Note) {
        notes.append(note)
        saveNotes()
    }
    
    func deleteNote(at indexSet: IndexSet) {
        notes.remove(atOffsets: indexSet)
        saveNotes()
    }
    
    func deleteNote(note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
            saveNotes()
        }
    }
    
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            userDefaults.set(encoded, forKey: notesKey)
        }
    }
    
    private func loadNotes() {
        if let data = userDefaults.data(forKey: notesKey),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decodedNotes
        }
    }
}
