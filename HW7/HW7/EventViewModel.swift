//
//  EventViewModel.swift
//  HW7
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import Foundation
import SwiftUI

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    
    init() {
        loadEvents()
    }
    
    // MARK: - Event Management
    
    func addEvent(_ event: Event) {
        events.append(event)
        saveEvents()
    }
    
    func deleteEvent(at indexSet: IndexSet) {
        events.remove(atOffsets: indexSet)
        saveEvents()
    }
    
    func deleteEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events.remove(at: index)
            saveEvents()
        }
    }
    
    func updateEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index] = event
            saveEvents()
        }
    }
    
    func toggleReminder(for event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].hasReminder.toggle()
            saveEvents()
        }
    }
    
    // MARK: - Data Persistence
    
    private func saveEvents() {
        if let encoded = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encoded, forKey: "SavedEvents")
        }
    }
    
    private func loadEvents() {
        if let data = UserDefaults.standard.data(forKey: "SavedEvents"),
           let decoded = try? JSONDecoder().decode([Event].self, from: data) {
            events = decoded
        }
    }
}
