import Testing
@testable import ToDo

@Test
func testTasksReflectTaskManager() throws {
    let mock = MockTaskStorage()
    let manager = try TaskManager(storage: mock)
    let viewModel = TaskListViewModel(taskManager: manager)

    try manager.addTask(title: "Estudar SwiftUI", priority: 2)

    #expect(viewModel.tasks.count == 1)
    #expect(viewModel.tasks[0].title == "Estudar SwiftUI")
}

@Test
func testViewModelUsesInjectedTaskManager() throws {
    let mock = MockTaskStorage()
    let manager = try TaskManager(storage: mock)
    let viewModel = TaskListViewModel(taskManager: manager)

    let result = try viewModel.addTask(
        title: "Testar ViewModel",
        priority: 1
    )

    #expect(result == .success)
    #expect(manager.tasks.count == 1)
    #expect(mock.savedTasks.count == 1)
}