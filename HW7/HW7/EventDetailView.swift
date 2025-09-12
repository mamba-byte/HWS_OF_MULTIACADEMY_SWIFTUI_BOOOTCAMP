//
//  EventDetailView.swift
//  HW7
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import SwiftUI

struct EventDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EventViewModel
    let event: Event
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with icon and title
                HStack {
                    Image(systemName: event.type.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                        .frame(width: 60, height: 60)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(event.type.rawValue)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Event details
                VStack(alignment: .leading, spacing: 16) {
                    DetailRow(
                        icon: "calendar",
                        title: "Tarih",
                        value: formatDate(event.date)
                    )
                    
                    DetailRow(
                        icon: "clock",
                        title: "Saat",
                        value: formatTime(event.date)
                    )
                    
                    DetailRow(
                        icon: event.hasReminder ? "bell.fill" : "bell.slash",
                        title: "Hatırlatıcı",
                        value: event.hasReminder ? "Açık" : "Kapalı"
                    )
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Delete button
                Button(action: {
                    viewModel.deleteEvent(event)
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Etkinliği Sil")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Etkinlik Detayı")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: date)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: date)
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(title)
                .fontWeight(.medium)
            
            Spacer()
            
            Text(value)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    EventDetailView(
        viewModel: EventViewModel(),
        event: Event(
            title: "Örnek Etkinlik",
            date: Date(),
            type: .birthday,
            hasReminder: true
        )
    )
}
