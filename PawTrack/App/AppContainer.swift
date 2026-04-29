import Foundation
import SwiftData
import SwiftUI

struct AppContainer {
    let modelContainer: ModelContainer
    let notificationService: NotificationService
    let exportService: ExportService
    let analytics: AnalyticsService

    static let live: AppContainer = {
        let schema = Schema([
            PetProfile.self,
            ActivityLog.self,
            FoodWaterLog.self,
            MedicationLog.self,
            WeightEntry.self,
            ReminderItem.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        let modelContainer = try! ModelContainer(for: schema, configurations: [modelConfiguration])
        return AppContainer(
            modelContainer: modelContainer,
            notificationService: NotificationService(),
            exportService: ExportService(),
            analytics: AnalyticsService()
        )
    }()
}

private struct AppContainerKey: EnvironmentKey {
    static let defaultValue: AppContainer = .live
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}

extension View {
    func environment(_ appContainer: AppContainer) -> some View {
        environment(\.appContainer, appContainer)
    }
}
