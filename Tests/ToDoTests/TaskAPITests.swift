import Testing
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import ToDo

// Verifica se o JSON é convertido corretamente
@Test
func testDecodeRemoteTask() throws {
    let json = """
    {
        "userId": 1,
        "id": 1,
        "title": "Estudar Swift",
        "completed": false
    }
    """

    let data = Data(json.utf8)

    let task = try JSONDecoder().decode(
        RemoteTask.self,
        from: data
    )

    #expect(task.userId == 1)
    #expect(task.id == 1)
    #expect(task.title == "Estudar Swift")
    #expect(task.completed == false)
}

// Verifica se um JSON inválido gera erro
@Test
func testDecodeInvalidRemoteTask() {
    let json = """
    {
        "id": 1,
        "title": "Estudar Swift"
    }
    """

    let data = Data(json.utf8)

    #expect(throws: (any Error).self) {
        try JSONDecoder().decode(
            RemoteTask.self,
            from: data
        )
    }
}

@Test
func testFetchTaskReturnsDecodedTask() async throws {
    let json = """
    {
        "userId": 1,
        "id": 1,
        "title": "Estudar Swift",
        "completed": false
    }
    """

    let data = Data(json.utf8)

    MockURLProtocol.requestHandler = { request in
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )!

        return (response, data)
    }

    defer {
        MockURLProtocol.requestHandler = nil
    }

    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]

    let session = URLSession(configuration: configuration)
    defer {
        session.invalidateAndCancel()
    }

    let service = TaskAPIService(session: session)

    let task = try await service.fetchTask()

    #expect(task.userId == 1)
    #expect(task.id == 1)
    #expect(task.title == "Estudar Swift")
    #expect(task.completed == false)
}