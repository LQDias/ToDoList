import Foundation
@testable import ToDo

final class MockTaskStorage: TaskStorageProtocol {

    private(set) var savedTasks: [ToDoList] = []

    func save(_ tasks: [ToDoList]) throws {
        savedTasks = tasks
    }

    func load() throws -> [ToDoList] {
        return savedTasks
    }
}