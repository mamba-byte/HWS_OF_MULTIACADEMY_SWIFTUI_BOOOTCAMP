import Foundation

final class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [TaskItem] = []
    @Published var newTaskTitle: String = ""

    // MARK: - Intents
    func addTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let task = TaskItem(title: trimmed, isCompleted: false)
        tasks.append(task)
        newTaskTitle = ""
    }

    func deleteTasks(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleCompletion(for task: TaskItem) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks[index].isCompleted.toggle()
    }
}


