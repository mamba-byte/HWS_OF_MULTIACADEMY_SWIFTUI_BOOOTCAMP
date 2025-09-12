//
//  NoteDetailView.swift
//  HW8
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import SwiftUI

struct NoteDetailView: View {
    let note: Note
    @ObservedObject var noteManager: NoteManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Başlık")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(note.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("İçerik")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(note.content)
                            .font(.body)
                            .lineLimit(nil)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tarih")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(note.date, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(note.date, style: .time)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Not Detayı")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sil") {
                        noteManager.deleteNote(note: note)
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}
