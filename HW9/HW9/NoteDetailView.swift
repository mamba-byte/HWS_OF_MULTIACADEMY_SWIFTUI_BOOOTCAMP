//
//  NoteDetailView.swift
//  HW9
//
//  Created by İsmail Can Durak on 20.09.2025.
//

import SwiftUI
import CoreData

struct NoteDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    let item: Item
    @State private var title: String
    @State private var content: String
    @State private var isEditing = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showingDeleteAlert = false
    
    init(item: Item) {
        self.item = item
        _title = State(initialValue: item.title ?? "")
        _content = State(initialValue: item.content ?? "")
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if isEditing {
                editingView
            } else {
                readingView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    if isEditing {
                        Button("Cancel") {
                            cancelEditing()
                        }
                        Button("Save") {
                            saveChanges()
                        }
                        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    } else {
                        Button("Edit") {
                            startEditing()
                        }
                        Button("Delete") {
                            showingDeleteAlert = true
                        }
                        .foregroundColor(.red)
                    }
                }
            }
        }
        .alert("Error", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .alert("Delete Note", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deleteNote()
            }
        } message: {
            Text("Are you sure you want to delete this note? This action cannot be undone.")
        }
    }
    
    private var readingView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Created")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(item.date ?? Date(), formatter: dateFormatter)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Content")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(content.isEmpty ? "No content" : content)
                        .font(.body)
                        .foregroundColor(content.isEmpty ? .secondary : .primary)
                }
            }
            .padding()
        }
    }
    
    private var editingView: some View {
        Form {
            Section(header: Text("Note Details")) {
                TextField("Title", text: $title)
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Content")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    TextEditor(text: $content)
                        .frame(minHeight: 300)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Last Modified")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(item.date ?? Date(), formatter: dateFormatter)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private func startEditing() {
        isEditing = true
    }
    
    private func cancelEditing() {
        title = item.title ?? ""
        content = item.content ?? ""
        isEditing = false
    }
    
    private func saveChanges() {
        withAnimation {
            item.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
            item.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
            item.date = Date()
            
            do {
                try viewContext.save()
                isEditing = false
            } catch {
                alertMessage = "Failed to save changes: \(error.localizedDescription)"
                showingAlert = true
            }
        }
    }
    
    private func deleteNote() {
        withAnimation {
            viewContext.delete(item)
            
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                alertMessage = "Failed to delete note: \(error.localizedDescription)"
                showingAlert = true
            }
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let newItem = Item(context: context)
    newItem.id = UUID()
    newItem.title = "Sample Note"
    newItem.content = "This is a sample note content for preview purposes."
    newItem.date = Date()
    
    return NavigationView {
        NoteDetailView(item: newItem)
    }
    .environment(\.managedObjectContext, context)
}
