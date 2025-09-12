//
//  Note.swift
//  HW8
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import Foundation

struct Note: Identifiable, Codable {
    let id = UUID()
    var title: String
    var content: String
    var date: Date
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.date = Date()
    }
}
