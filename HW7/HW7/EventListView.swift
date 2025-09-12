//
//  EventListView.swift
//  HW7
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import SwiftUI

struct EventListView: View {
    @StateObject private var viewModel = EventViewModel()
    @State private var showingAddEvent = false
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.events.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.events) { event in
                            NavigationLink(destination: EventDetailView(viewModel: viewModel, event: event)) {
                                EventRowView(event: event)
                            }
                        }
                        .onDelete(perform: viewModel.deleteEvent)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Etkinlikler")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddEvent = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddEvent) {
                AddEventView(viewModel: viewModel)
            }
        }
    }
}

struct EventRowView: View {
    let event: Event
    
    var body: some View {
        HStack {
            // Event type icon
            Image(systemName: event.type.icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            // Event details
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(event.type.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(formatEventDate(event.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Reminder indicator
            if event.hasReminder {
                Image(systemName: "bell.fill")
                    .foregroundColor(.orange)
                    .font(.caption)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func formatEventDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: date)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Henüz etkinlik yok")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            Text("Yeni bir etkinlik eklemek için + butonuna tıklayın")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EventListView()
}
