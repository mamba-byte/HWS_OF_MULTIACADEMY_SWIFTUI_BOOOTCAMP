//
//  PokemonDetailView.swift
//  HW10
//
//  Created by İsmail Can Durak on 25.09.2025.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemonName: String
    @State private var pokemonDetail: PokemonDetail?
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if isLoading {
                    ProgressView("Loading Pokemon details...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = errorMessage {
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
                                await loadPokemonDetail()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let pokemon = pokemonDetail {
                    // Pokemon Header
                    VStack(spacing: 16) {
                        // Pokemon Image
                        AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    ProgressView()
                                        .scaleEffect(1.5)
                                )
                        }
                        .frame(width: 200, height: 200)
                        
                        // Pokemon Name and ID
                        VStack(spacing: 8) {
                            Text(pokemon.name.capitalized)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("#\(String(format: "%03d", pokemon.id))")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    
                    // Pokemon Stats
                    VStack(alignment: .leading, spacing: 16) {
                        // Basic Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Basic Information")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Height")
                                        .font(.headline)
                                    Text(pokemon.formattedHeight)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("Weight")
                                        .font(.headline)
                                    Text(pokemon.formattedWeight)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        // Types
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Types")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            HStack {
                                ForEach(pokemon.types, id: \.slot) { type in
                                    Text(type.type.name.capitalized)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(typeColor(for: type.type.name))
                                        .foregroundColor(.white)
                                        .cornerRadius(16)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        // Abilities
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Abilities")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            ForEach(pokemon.abilities, id: \.slot) { ability in
                                HStack {
                                    Text(ability.ability.name.capitalized)
                                        .font(.subheadline)
                                    if ability.isHidden {
                                        Text("(Hidden)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 2)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        // Stats
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Base Stats")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            ForEach(pokemon.stats, id: \.stat.name) { stat in
                                HStack {
                                    Text(stat.stat.name.capitalized)
                                        .font(.subheadline)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    Text("\(stat.baseStat)")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .frame(width: 40, alignment: .trailing)
                                    
                                    ProgressView(value: Double(stat.baseStat), total: 255)
                                        .progressViewStyle(LinearProgressViewStyle(tint: statColor(for: stat.stat.name)))
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(pokemonName.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadPokemonDetail()
        }
    }
    
    private func loadPokemonDetail() async {
        isLoading = true
        errorMessage = nil
        
        do {
            pokemonDetail = try await PokemonService.shared.fetchPokemonDetail(name: pokemonName)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func typeColor(for type: String) -> Color {
        switch type.lowercased() {
        case "normal": return .gray
        case "fire": return .red
        case "water": return .blue
        case "electric": return .yellow
        case "grass": return .green
        case "ice": return .cyan
        case "fighting": return .orange
        case "poison": return .purple
        case "ground": return .brown
        case "flying": return .indigo
        case "psychic": return .pink
        case "bug": return .green.opacity(0.8)
        case "rock": return .gray.opacity(0.8)
        case "ghost": return .purple.opacity(0.8)
        case "dragon": return .blue.opacity(0.8)
        case "dark": return .black
        case "steel": return .gray.opacity(0.6)
        case "fairy": return .pink.opacity(0.8)
        default: return .gray
        }
    }
    
    private func statColor(for stat: String) -> Color {
        switch stat.lowercased() {
        case "hp": return .green
        case "attack": return .red
        case "defense": return .blue
        case "special-attack": return .purple
        case "special-defense": return .orange
        case "speed": return .yellow
        default: return .gray
        }
    }
}

#Preview {
    NavigationView {
        PokemonDetailView(pokemonName: "pikachu")
    }
}
