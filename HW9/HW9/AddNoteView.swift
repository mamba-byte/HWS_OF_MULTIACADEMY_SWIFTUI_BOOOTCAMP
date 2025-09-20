//
//  AddNoteView.swift
//  HW9
//
//  Created by İsmail Can Durak on 20.09.2025.
//

import SwiftUI
import CoreData

struct AddNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var content = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Note Details")) {
                    TextField("Title", text: $title)
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Content")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        TextEditor(text: $content)
                            .frame(minHeight: 200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
            }
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveNote()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .alert("Error", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func saveNote() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
            newItem.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
            newItem.date = Date()
            
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                alertMessage = "Failed to save note: \(error.localizedDescription)"
                showingAlert = true
            }
        }
    }
}

#Preview {
    AddNoteView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
