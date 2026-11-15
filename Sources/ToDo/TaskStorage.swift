import Foundation

enum TaskStorageError: Error {
    case applicationSupportDirectoryUnavailable
    case directoryCreationFailed(Error)
    case fileReadFailed(Error)
    case fileWriteFailed(Error)
    case encodingFailed(Error)
    case decodingFailed(Error)
}

protocol TaskStorageProtocol {
    func save(_ tasks: [ToDoList]) throws
    func load() throws -> [ToDoList]
}

final class TaskStorage: TaskStorageProtocol {

    private let fileURL: URL

    init(fileURL: URL? = nil) throws {
        let resolvedURL: URL

        if let fileURL {
            resolvedURL = fileURL
        } else {
            guard let appSupportDirectory = FileManager.default.urls(
                for: .applicationSupportDirectory,
                in: .userDomainMask
            ).first else {
                throw TaskStorageError.applicationSupportDirectoryUnavailable
            }

            let folderURL = appSupportDirectory
                .appendingPathComponent("ToDoList")

            resolvedURL = folderURL.appendingPathComponent("tasks.json")
        }

        do {
            try FileManager.default.createDirectory(
                at: resolvedURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
        } catch {
            throw TaskStorageError.directoryCreationFailed(error)
        }

        self.fileURL = resolvedURL
    }

    func save(_ tasks: [ToDoList]) throws {
        let data: Data

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            data = try encoder.encode(tasks)
        } catch {
            throw TaskStorageError.encodingFailed(error)
        }

        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            throw TaskStorageError.fileWriteFailed(error)
        }
    }

    func load() throws -> [ToDoList] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return []
        }

        let data: Data

        do {
            data = try Data(contentsOf: fileURL)
        } catch {
            throw TaskStorageError.fileReadFailed(error)
        }

        do {
            return try JSONDecoder().decode([ToDoList].self, from: data)
        } catch {
            throw TaskStorageError.decodingFailed(error)
        }
    }
}

extension TaskStorageError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .applicationSupportDirectoryUnavailable:
            return "Não foi possível localizar a pasta de dados."
        case .directoryCreationFailed(let error):
            return "Falha ao criar diretório: \(error.localizedDescription)"
        case .fileReadFailed(let error):
            return "Falha ao ler arquivo: \(error.localizedDescription)"
        case .fileWriteFailed(let error):
            return "Falha ao salvar arquivo: \(error.localizedDescription)"
        case .encodingFailed(let error):
            return "Falha ao converter tarefas: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "Falha ao interpretar o arquivo: \(error.localizedDescription)"
        }
    }
}
