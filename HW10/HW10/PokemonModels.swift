//
//  PokemonModels.swift
//  HW10
//
//  Created by İsmail Can Durak on 25.09.2025.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable {
    let name: String
    let url: String
    
    var id: String { name }
}

// MARK: - Pokemon Detail Response
struct PokemonDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    let stats: [PokemonStat]
    
    var formattedHeight: String {
        let heightInMeters = Double(height) / 10.0
        return String(format: "%.1f m", heightInMeters)
    }
    
    var formattedWeight: String {
        let weightInKg = Double(weight) / 10.0
        return String(format: "%.1f kg", weightInKg)
    }
}

struct PokemonSprites: Codable {
    let frontDefault: String?
    let frontShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct PokemonType: Codable {
    let slot: Int
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
    let url: String
}

struct PokemonAbility: Codable {
    let ability: AbilityInfo
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct AbilityInfo: Codable {
    let name: String
    let url: String
}

struct PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: StatInfo
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct StatInfo: Codable {
    let name: String
    let url: String
}
