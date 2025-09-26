//
//  Views.swift
//  HW11
//
//  Created by Assistant on 26.09.2025.
//

import SwiftUI

struct CharacterRowView: View {
    let character: RMCharacter
    let isFavorite: Bool

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: character.image) { phase in
                switch phase {
                case .empty:
                    ProgressView().frame(width: 60, height: 60)
                case .success(let image):
                    image.resizable().scaledToFill().frame(width: 60, height: 60).clipped().cornerRadius(8)
                case .failure:
                    Color.gray.frame(width: 60, height: 60).cornerRadius(8)
                @unknown default:
                    Color.gray.frame(width: 60, height: 60).cornerRadius(8)
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name).font(.headline)
                Text("\(character.status) · \(character.species)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if isFavorite {
                Image(systemName: "heart.fill").foregroundColor(.red)
            }
        }
        .padding(.vertical, 6)
    }
}

struct CharacterDetailView: View {
    let character: RMCharacter
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: character.image) { phase in
                    switch phase {
                    case .empty: ProgressView().frame(maxWidth: .infinity, minHeight: 240)
                    case .success(let image): image.resizable().scaledToFit().cornerRadius(12)
                    case .failure: Color.gray.frame(height: 240).cornerRadius(12)
                    @unknown default: Color.gray.frame(height: 240).cornerRadius(12)
                    }
                }
                Text(character.name).font(.largeTitle).bold()
                Group {
                    Text("Status: \(character.status)")
                    Text("Species: \(character.species)")
                    Text("Gender: \(character.gender)")
                }.font(.body)
                Button {
                    favorites.toggle(character.id)
                } label: {
                    Label(favorites.isFavorite(character.id) ? "Favorilerden çıkar" : "Favorilere ekle",
                          systemImage: favorites.isFavorite(character.id) ? "heart.slash" : "heart")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CharactersListView: View {
    @StateObject private var vm = CharactersViewModel()
    @StateObject private var favorites = FavoritesStore()

    var body: some View {
        List {
            if vm.errorMessage != nil && vm.characters.isEmpty {
                Section { Text("Bir şeyler ters gitti. Lütfen tekrar deneyin.") }
            }
            ForEach(vm.characters) { character in
                NavigationLink {
                    CharacterDetailView(character: character)
                        .environmentObject(favorites)
                } label: {
                    CharacterRowView(character: character, isFavorite: favorites.isFavorite(character.id))
                }
                .task {
                    await vm.loadMoreIfNeeded(currentItem: character)
                }
                .swipeActions(edge: .trailing) {
                    Button { favorites.toggle(character.id) } label: {
                        Label(favorites.isFavorite(character.id) ? "Unfavorite" : "Favorite",
                              systemImage: favorites.isFavorite(character.id) ? "heart.slash" : "heart")
                    }.tint(.pink)
                }
            }
            if vm.isLoading && !vm.characters.isEmpty {
                HStack { Spacer(); ProgressView(); Spacer() }
            }
            if !vm.hasMore && !vm.characters.isEmpty {
                HStack { Spacer(); Text("Sonuçların sonuna geldiniz").foregroundColor(.secondary); Spacer() }
            }
        }
        .overlay {
            if vm.isLoading && vm.characters.isEmpty { ProgressView() }
            else if vm.characters.isEmpty && vm.errorMessage == nil { Text("Sonuç bulunamadı").foregroundColor(.secondary) }
        }
        .refreshable { await vm.refresh() }
        .searchable(text: Binding(
            get: { vm.query },
            set: { text in Task { await vm.updateQuery(text) } }
        ))
        .navigationTitle("Karakterler")
        .task { if vm.characters.isEmpty { await vm.refresh() } }
    }
}


