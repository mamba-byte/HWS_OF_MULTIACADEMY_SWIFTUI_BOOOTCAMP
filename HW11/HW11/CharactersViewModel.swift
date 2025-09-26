//
//  CharactersViewModel.swift
//  HW11
//
//  Created by Assistant on 26.09.2025.
//

import Foundation

@MainActor
final class CharactersViewModel: ObservableObject {
    @Published private(set) var characters: [RMCharacter] = []
    @Published var query: String = ""
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = nil
    @Published private(set) var hasMore: Bool = true

    private var currentPage: Int = 1
    private let api: CharactersAPI

    init(api: CharactersAPI = NetworkService()) {
        self.api = api
    }

    func refresh() async {
        currentPage = 1
        hasMore = true
        await load(reset: true)
    }

    func loadMoreIfNeeded(currentItem item: RMCharacter?) async {
        guard hasMore, !isLoading else { return }
        guard let item = item else {
            await load(reset: false)
            return
        }
        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -5, limitedBy: characters.startIndex) ?? characters.startIndex
        if characters.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            await load(reset: false)
        }
    }

    func updateQuery(_ text: String) async {
        query = text
        await refresh()
    }

    private func load(reset: Bool) async {
        isLoading = true
        errorMessage = nil
        do {
            let page = reset ? 1 : currentPage
            let pageResult = try await api.fetchCharacters(page: page, name: query)
            if reset { characters = [] }
            characters += pageResult.results
            currentPage = page + 1
            hasMore = pageResult.info.next != nil && !pageResult.results.isEmpty
        } catch {
            // Map 404 empty to empty state (handled in service), other errors display
            if reset { characters = [] }
            hasMore = false
            errorMessage = (error as NSError).localizedDescription
        }
        isLoading = false
    }
}


