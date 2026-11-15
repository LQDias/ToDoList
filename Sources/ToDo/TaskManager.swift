import Foundation

enum AddTaskResult: Equatable {
    case success
    case emptyTitle
    case invalidPriority
}

class TaskManager {
    private(set) var tasks: [ToDoList] = []
    private let storage: any TaskStorageProtocol

    init(storage: any TaskStorageProtocol) throws {
        self.storage = storage
        self.tasks = try storage.load()
    }

    convenience init() throws {
        try self.init(storage: TaskStorage())
    }

    @discardableResult
    func addTask(title: String, priority: Int) throws -> AddTaskResult {
        let cleanedTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !cleanedTitle.isEmpty else {
            return .emptyTitle
        }

        guard (1...3).contains(priority) else {
            return .invalidPriority
        }

        let task = ToDoList(title: cleanedTitle, priority: priority)
        var updatedTasks = tasks
        updatedTasks.append(task)

        try storage.save(updatedTasks)
        tasks = updatedTasks

        return .success
    }

    func completeTask(at index: Int) throws -> Bool {
        guard tasks.indices.contains(index) else {
            return false
        }

        var updatedTasks = tasks
        updatedTasks[index].isCompleted = true

        try storage.save(updatedTasks)
        tasks = updatedTasks

        return true
    }

    func deleteTask(at index: Int) throws -> Bool {
        guard tasks.indices.contains(index) else {
            return false
        }

        var updatedTasks = tasks
        updatedTasks.remove(at: index)

        try storage.save(updatedTasks)
        tasks = updatedTasks

        return true
    }
}