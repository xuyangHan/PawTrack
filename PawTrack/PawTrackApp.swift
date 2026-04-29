import SwiftUI
import SwiftData

@main
struct PawTrackApp: App {
    private let container = AppContainer.live

    var body: some Scene {
        WindowGroup {
            RootRouterView()
                .environment(container)
                .modelContainer(container.modelContainer)
        }
    }
}
