//
//  ContentView.swift
//  HW5
//
//  Created by İsmail Can Durak on 10.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack {
                    TextField("Yeni görev ekle...", text: $viewModel.newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .onSubmit { viewModel.addTask() }

                    Button(action: viewModel.addTask) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                    }
                    .disabled(viewModel.newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)

                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Button {
                                viewModel.toggleCompletion(for: task)
                            } label: {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(task.isCompleted ? .green : .secondary)
                            }
                            .buttonStyle(.plain)

                            Text(task.title)
                                .strikethrough(task.isCompleted)
                                .foregroundStyle(task.isCompleted ? .secondary : .primary)

                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture { viewModel.toggleCompletion(for: task) }
                    }
                    .onDelete(perform: viewModel.deleteTasks)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Görevler")
        }
    }
}

#Preview {
    ContentView()
}
