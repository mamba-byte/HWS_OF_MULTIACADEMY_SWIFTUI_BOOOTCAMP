//
//  Models.swift
//  HW11
//
//  Created by Assistant on 26.09.2025.
//

import Foundation

struct APIPage<T: Codable>: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [T]
}

struct RMCharacter: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: URL
}


