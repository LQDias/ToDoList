import Foundation

do {
    let cli = try ToDoListCLI()
    await cli.run()
} catch {
    print("Não foi possível iniciar o aplicativo:")
    print(error.localizedDescription)
}
