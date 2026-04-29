import SwiftUI
import SwiftData

struct RootRouterView: View {
    @Query(sort: \PetProfile.createdAt, order: .forward) private var pets: [PetProfile]

    var body: some View {
        Group {
            if pets.isEmpty {
                OnboardingWelcomeView()
            } else {
                MainTabView()
            }
        }
    }
}

private struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeDashboardView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                LogsListView()
            }
            .tabItem {
                Label("Logs", systemImage: "list.bullet.clipboard")
            }

            NavigationStack {
                HealthReportsView()
            }
            .tabItem {
                Label("Reports", systemImage: "chart.xyaxis.line")
            }

            NavigationStack {
                PetProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "pawprint.fill")
            }
        }
    }
}
