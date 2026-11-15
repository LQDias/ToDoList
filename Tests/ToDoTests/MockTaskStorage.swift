import Foundation
@testable import ToDo

enum MockStorageError: Error {
    case saveFailed
    case loadFailed
}

final class MockTaskStorage: TaskStorageProtocol {

    private(set) var savedTasks: [ToDoList]

    private let shouldFailOnSave: Bool
    private let shouldFailOnLoad: Bool

    init(
        initialTasks: [ToDoList] = [],
        shouldFailOnSave: Bool = false,
        shouldFailOnLoad: Bool = false
    ) {
        self.savedTasks = initialTasks
        self.shouldFailOnSave = shouldFailOnSave
        self.shouldFailOnLoad = shouldFailOnLoad
    }

    func save(_ tasks: [ToDoList]) throws {
        if shouldFailOnSave {
            throw MockStorageError.saveFailed
        }

        savedTasks = tasks
    }

    func load() throws -> [ToDoList] {
        if shouldFailOnLoad {
            throw MockStorageError.loadFailed
        }

        return savedTasks
    }
}
