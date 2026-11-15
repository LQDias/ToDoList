import Foundation

final class TaskListViewModel {

    private let taskManager: TaskManager

    init(taskManager: TaskManager) {
        self.taskManager = taskManager
    }

    convenience init() throws {
        try self.init(taskManager: TaskManager())
    }

    var tasks: [ToDoList] {
        return taskManager.tasks
    }

    func addTask(title: String, priority: Int) throws -> AddTaskResult {
        return try taskManager.addTask(
            title: title,
            priority: priority
        )
    }

    func completeTask(at index: Int) throws -> Bool {
        return try taskManager.completeTask(at: index)
    }

    func deleteTask(at index: Int) throws -> Bool {
        return try taskManager.deleteTask(at: index)
    }
}
