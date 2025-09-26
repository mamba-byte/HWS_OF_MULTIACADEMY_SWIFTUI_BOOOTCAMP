//
//  NetworkService.swift
//  HW11
//
//  Created by Assistant on 26.09.2025.
//

import Foundation

protocol CharactersAPI {
    func fetchCharacters(page: Int, name: String?) async throws -> APIPage<RMCharacter>
}

final class NetworkService: CharactersAPI {
    private let baseURL = URL(string: "https://rickandmortyapi.com/api")!
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared) {
        self.session = session
        let decoder = JSONDecoder()
        self.decoder = decoder
    }

    func fetchCharacters(page: Int, name: String?) async throws -> APIPage<RMCharacter> {
        var components = URLComponents(url: baseURL.appending(path: "character"), resolvingAgainstBaseURL: false)!
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "page", value: String(page))]
        if let name, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        components.queryItems = queryItems
        let url = components.url!

        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.timeoutInterval = 20

        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        guard 200..<300 ~= http.statusCode else {
            if http.statusCode == 404 { // empty search result
                // Rick&Morty returns 404 for empty search; map to empty page
                return APIPage(info: .init(count: 0, pages: 0, next: nil, prev: nil), results: [])
            }
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(APIPage<RMCharacter>.self, from: data)
    }
}


