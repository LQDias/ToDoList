import Testing
@testable import ToDo

@Test
func testAddTaskDoesNotChangeStateWhenSaveFails() throws {
    let storage = MockTaskStorage(shouldFailOnSave: true)
    let manager = try TaskManager(storage: storage)

    #expect(throws: MockStorageError.self) {
        try manager.addTask(title: "Nova tarefa", priority: 1)
    }

    #expect(manager.tasks.isEmpty)
    #expect(storage.savedTasks.isEmpty)
}

@Test
func testCompleteTaskDoesNotChangeStateWhenSaveFails() throws {
    let task = ToDoList(title: "Estudar Swift", priority: 2)
    let storage = MockTaskStorage(
        initialTasks: [task],
        shouldFailOnSave: true
    )
    let manager = try TaskManager(storage: storage)

    #expect(throws: MockStorageError.self) {
        try manager.completeTask(at: 0)
    }

    #expect(manager.tasks.count == 1)
    #expect(manager.tasks[0].isCompleted == false)
    #expect(storage.savedTasks[0].isCompleted == false)
}

@Test
func testDeleteTaskDoesNotChangeStateWhenSaveFails() throws {
    let task = ToDoList(title: "Estudar Swift", priority: 2)
    let storage = MockTaskStorage(
        initialTasks: [task],
        shouldFailOnSave: true
    )
    let manager = try TaskManager(storage: storage)

    #expect(throws: MockStorageError.self) {
        try manager.deleteTask(at: 0)
    }

    #expect(manager.tasks.count == 1)
    #expect(manager.tasks[0].title == "Estudar Swift")
    #expect(storage.savedTasks.count == 1)
}

@Test
func testTaskManagerInitializationThrowsWhenLoadFails() {
    let storage = MockTaskStorage(shouldFailOnLoad: true)

    #expect(throws: MockStorageError.self) {
        try TaskManager(storage: storage)
    }
}