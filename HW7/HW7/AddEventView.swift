//
//  AddEventView.swift
//  HW7
//
//  Created by İsmail Can Durak on 12.09.2025.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: EventViewModel
    
    @State private var title = ""
    @State private var selectedDate = Date()
    @State private var selectedType = EventType.other
    @State private var hasReminder = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Etkinlik Bilgileri")) {
                    TextField("Etkinlik Adı", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    DatePicker("Tarih", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(CompactDatePickerStyle())
                    
                    Picker("Tür", selection: $selectedType) {
                        ForEach(EventType.allCases, id: \.self) { type in
                            HStack {
                                Image(systemName: type.icon)
                                    .foregroundColor(.blue)
                                Text(type.rawValue)
                            }
                            .tag(type)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Toggle("Hatırlatıcı", isOn: $hasReminder)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
            }
            .navigationTitle("Yeni Etkinlik")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        saveEvent()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func saveEvent() {
        let newEvent = Event(
            title: title,
            date: selectedDate,
            type: selectedType,
            hasReminder: hasReminder
        )
        
        viewModel.addEvent(newEvent)
        dismiss()
    }
}

#Preview {
    AddEventView(viewModel: EventViewModel())
}
