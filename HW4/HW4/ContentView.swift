//
//  ContentView.swift
//  HW4
//
//  Created by İsmail Can Durak on 2.09.2025.
//

import SwiftUI

struct MasterItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var detail: String
    var isDone: Bool

    init(id: UUID = UUID(), title: String, detail: String, isDone: Bool = false) {
        self.id = id
        self.title = title
        self.detail = detail
        self.isDone = isDone
    }
}

final class MasterListViewModel: ObservableObject {
    @Published var items: [MasterItem]

    init() {
        // 10 initial items
        self.items = (1...10).map { index in
            MasterItem(title: "Yapılacak : \(index)", detail: "Bu, \(index). yapılacak", isDone: index % 3 == 0)
        }
    }

    var toDoItems: [MasterItem] { items.filter { !$0.isDone } }
    var doneItems: [MasterItem] { items.filter { $0.isDone } }

    func addItem(title: String, detail: String) {
        let newItem = MasterItem(title: title, detail: detail, isDone: false)
        items.insert(newItem, at: 0)
    }

    func delete(at offsets: IndexSet, doneSection: Bool) {
        let sectionItems = doneSection ? doneItems : toDoItems
        let idsToDelete = offsets.map { sectionItems[$0].id }
        items.removeAll { idsToDelete.contains($0.id) }
    }

    func toggleDone(_ item: MasterItem) {
        guard let index = items.firstIndex(of: item) else { return }
        items[index].isDone.toggle()
    }
}

struct ContentView: View {
    @StateObject private var viewModel = MasterListViewModel()
    @State private var showingAddSheet = false
    @State private var useAlternateView = false
    @State private var tintColor: Color = .blue

    private let possibleTints: [Color] = [.blue, .red, .green, .orange, .pink, .purple, .teal, .indigo, .mint, .brown]

    var body: some View {
        NavigationStack {
            Group {
                if useAlternateView {
                    alternateScrollView
                } else {
                    sectionedListView
                }
            }
            .navigationTitle("HW4")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    Button {
                        useAlternateView.toggle()
                    } label: {
                        Image(systemName: useAlternateView ? "list.bullet" : "square.grid.2x2")
                    }
                    .accessibilityLabel("Görünümü Değiştir")
                }
            }
        }
        .tint(tintColor)
        .onAppear {
            if let random = possibleTints.randomElement() {
                tintColor = random
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddItemView { title, detail in
                viewModel.addItem(title: title, detail: detail)
            }
        }
    }

    // MARK: Sectioned List
    private var sectionedListView: some View {
        List {
            Section("Yapılacaklar") {
                ForEach(viewModel.toDoItems) { item in
                    NavigationLink(value: item) {
                        rowView(for: item)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            viewModel.toggleDone(item)
                        } label: {
                            Label("Tamamla", systemImage: "checkmark")
                        }
                        .tint(.green)
                    }
                }
                .onDelete { offsets in
                    viewModel.delete(at: offsets, doneSection: false)
                }
            }

            Section("Yapıldı  ") {
                ForEach(viewModel.doneItems) { item in
                    NavigationLink(value: item) {
                        rowView(for: item)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            if let index = viewModel.items.firstIndex(of: item) {
                                viewModel.items.remove(at: index)
                            }
                        } label: {
                            Label("Sil", systemImage: "trash")
                        }
                        Button {
                            viewModel.toggleDone(item)
                        } label: {
                            Label("Geri Al", systemImage: "arrow.uturn.backward")
                        }
                        .tint(.orange)
                    }
                }
                .onDelete { offsets in
                    viewModel.delete(at: offsets, doneSection: true)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationDestination(for: MasterItem.self) { item in
            DetailView(item: item)
        }
    }

    private var alternateScrollView: some View {
        ScrollView {
            LazyVStack(spacing: 12, pinnedViews: []) {
                Text("Tamamlanacaklar")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                ForEach(viewModel.toDoItems) { item in
                    NavigationLink(value: item) {
                        rowCard(for: item)
                    }
                }

                Text("Tamamlananlar")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .horizontal])

                ForEach(viewModel.doneItems) { item in
                    NavigationLink(value: item) {
                        rowCard(for: item)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationDestination(for: MasterItem.self) { item in
            DetailView(item: item)
        }
    }

    // MARK: Row Views
    private func rowView(for item: MasterItem) -> some View {
        HStack(spacing: 12) {
            Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isDone ? .green : .secondary)
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .contentShape(Rectangle())
    }

    private func rowCard(for item: MasterItem) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(item.title)
                    .font(.headline)
                Spacer()
                Image(systemName: item.isDone ? "checkmark.seal.fill" : "chevron.right")
                    .foregroundStyle(item.isDone ? .green : .secondary)
            }
            Text(item.detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(.horizontal)
    }
}

// MARK: - Detail View
struct DetailView: View {
    let item: MasterItem
    private let randomSymbol: String = [
        "star.fill", "bolt.fill", "leaf.fill", "flame.fill", "heart.fill",
        "wand.and.stars", "paperplane.fill", "globe", "sparkles", "moon.stars.fill"
    ].randomElement() ?? "square.fill"

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: randomSymbol)
                .font(.system(size: 64, weight: .semibold))
                .symbolRenderingMode(.hierarchical)
                .padding(.top, 16)

            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.largeTitle.bold())
                Text(item.detail)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Detay")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Add Item Sheet
struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var detail: String = ""

    var onAdd: (String, String) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Başlık") {
                    TextField("Başlık girin", text: $title)
                }
                Section("Açıklama") {
                    TextField("Açıklama girin", text: $detail, axis: .vertical)
                        .lineLimit(3, reservesSpace: true)
                }
            }
            .navigationTitle("Yeni Öğe")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ekle") {
                        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        let trimmedDetail = detail.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmedTitle.isEmpty else { return }
                        onAdd(trimmedTitle, trimmedDetail.isEmpty ? "Açıklama yok" : trimmedDetail)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
