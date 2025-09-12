//
//  AddNoteView.swift
//  HW8
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var noteManager: NoteManager
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Not Bilgileri")) {
                    TextField("Başlık", text: $title)
                    TextField("İçerik", text: $content, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            .navigationTitle("Yeni Not")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        saveNote()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
    
    private func saveNote() {
        let newNote = Note(title: title, content: content)
        noteManager.addNote(newNote)
        dismiss()
    }
}
