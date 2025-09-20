//
//  NotesListView.swift
//  HW9
//
//  Created by İsmail Can Durak on 20.09.2025.
//

import SwiftUI
import CoreData

struct NotesListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var filteredItems: [Item] {
        if searchText.isEmpty {
            return Array(items)
        } else {
            return items.filter { item in
                item.title?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if filteredItems.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "note.text")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No Notes Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("Tap the + button to create your first note")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(filteredItems, id: \.id) { item in
                            NavigationLink(destination: NoteDetailView(item: item)) {
                                NoteRowView(item: item)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText, prompt: "Search notes...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNoteView()) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredItems[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct NoteRowView: View {
    let item: Item
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title ?? "Untitled")
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.primary)
            
            if let content = item.content, !content.isEmpty {
                Text(content)
                    .font(.body)
                    .lineLimit(2)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text(item.date ?? Date(), formatter: dateFormatter)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NotesListView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
