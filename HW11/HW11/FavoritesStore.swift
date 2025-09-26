//
//  FavoritesStore.swift
//  HW11
//
//  Created by Assistant on 26.09.2025.
//

import Foundation

final class FavoritesStore: ObservableObject {
    @Published private(set) var ids: Set<Int> = []
    private let defaultsKey = "favoriteCharacterIds"

    init() {
        load()
    }

    func isFavorite(_ id: Int) -> Bool { ids.contains(id) }

    func toggle(_ id: Int) {
        if ids.contains(id) { ids.remove(id) } else { ids.insert(id) }
        save()
    }

    private func load() {
        let saved = UserDefaults.standard.array(forKey: defaultsKey) as? [Int] ?? []
        ids = Set(saved)
    }

    private func save() {
        UserDefaults.standard.set(Array(ids), forKey: defaultsKey)
    }
}


