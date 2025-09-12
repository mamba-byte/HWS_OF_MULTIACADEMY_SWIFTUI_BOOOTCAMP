//
//  Event.swift
//  HW7
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import Foundation

struct Event: Identifiable, Codable {
    let id = UUID()
    var title: String
    var date: Date
    var type: EventType
    var hasReminder: Bool
    
    init(title: String, date: Date, type: EventType, hasReminder: Bool = false) {
        self.title = title
        self.date = date
        self.type = type
        self.hasReminder = hasReminder
    }
}

enum EventType: String, CaseIterable, Codable {
    case birthday = "Doğum Günü"
    case meeting = "Toplantı"
    case holiday = "Tatil"
    case sport = "Spor"
    case other = "Diğer"
    
    var icon: String {
        switch self {
        case .birthday:
            return "gift.fill"
        case .meeting:
            return "person.2.fill"
        case .holiday:
            return "airplane"
        case .sport:
            return "sportscourt.fill"
        case .other:
            return "star.fill"
        }
    }
}
