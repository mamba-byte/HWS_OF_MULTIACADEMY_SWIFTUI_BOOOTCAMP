//
//  PokemonService.swift
//  HW10
//
//  Created by İsmail Can Durak on 25.09.2025.
//

import Foundation

enum PokemonAPIError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode data"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

class PokemonService: ObservableObject {
    static let shared = PokemonService()
    private let baseURL = "https://pokeapi.co/api/v2"
    
    private init() {}
    
    func fetchPokemonList(limit: Int = 50, offset: Int = 0) async throws -> PokemonListResponse {
        guard let url = URL(string: "\(baseURL)/pokemon?limit=\(limit)&offset=\(offset)") else {
            throw PokemonAPIError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(PokemonListResponse.self, from: data)
        } catch let error as PokemonAPIError {
            throw error
        } catch {
            throw PokemonAPIError.networkError(error)
        }
    }
    
    func fetchPokemonDetail(name: String) async throws -> PokemonDetail {
        guard let url = URL(string: "\(baseURL)/pokemon/\(name.lowercased())") else {
            throw PokemonAPIError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(PokemonDetail.self, from: data)
        } catch let error as PokemonAPIError {
            throw error
        } catch {
            throw PokemonAPIError.networkError(error)
        }
    }
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        guard let url = URL(string: "\(baseURL)/pokemon/\(id)") else {
            throw PokemonAPIError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(PokemonDetail.self, from: data)
        } catch let error as PokemonAPIError {
            throw error
        } catch {
            throw PokemonAPIError.networkError(error)
        }
    }
}

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    private let pokemonService = PokemonService.shared
    
    var filteredPokemon: [PokemonListItem] {
        if searchText.isEmpty {
            return pokemonList
        } else {
            return pokemonList.filter { pokemon in
                pokemon.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func loadPokemon() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await pokemonService.fetchPokemonList(limit: 100, offset: 0)
            pokemonList = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
