//
//  ContentView.swift
//  HW10
//
//  Created by İsmail Can Durak on 25.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Pokemon...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        Text("Bir hata oluştu")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(errorMessage)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button("Tekrar Dene") {
                            Task {
                                await viewModel.loadPokemon()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                            TextField("Pokemon ara...", text: $viewModel.searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.horizontal)
                        
                        // Pokemon List
                        List(viewModel.filteredPokemon) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemonName: pokemon.name)) {
                                PokemonRowView(pokemon: pokemon)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationTitle("Pokemon")
            .task {
                await viewModel.loadPokemon()
            }
            .refreshable {
                await viewModel.loadPokemon()
            }
        }
    }
}

struct PokemonRowView: View {
    let pokemon: PokemonListItem
    @State private var pokemonDetail: PokemonDetail?
    
    var body: some View {
        HStack(spacing: 12) {
            // Pokemon Image
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(extractPokemonId())\(pokemon.name == "nidoran-m" || pokemon.name == "nidoran-f" ? "" : "").png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        ProgressView()
                            .scaleEffect(0.8)
                    )
            }
            .frame(width: 60, height: 60)
            
            // Pokemon Info
            VStack(alignment: .leading, spacing: 4) {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .fontWeight(.bold)
                
                if let detail = pokemonDetail {
                    HStack {
                        Text("Height: \(detail.formattedHeight)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Weight: \(detail.formattedWeight)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
            
            // Arrow
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding(.vertical, 4)
        .task {
            await loadPokemonDetail()
        }
    }
    
    private func extractPokemonId() -> String {
        let components = pokemon.url.components(separatedBy: "/")
        return components[components.count - 2]
    }
    
    private func loadPokemonDetail() async {
        do {
            pokemonDetail = try await PokemonService.shared.fetchPokemonDetail(name: pokemon.name)
        } catch {
            print("Failed to load Pokemon detail: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
