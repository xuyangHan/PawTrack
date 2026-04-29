import SwiftUI

struct SettingsAndLegalView: View {
    var body: some View {
        List {
            Section("Accessibility") {
                Text("Supports Dynamic Type and VoiceOver labels.")
                Text("High contrast palette aligned with design tokens.")
            }
            Section("Privacy") {
                Text("All health data is stored locally on-device.")
                Text("Notifications are used only for your reminders.")
            }
            Section("Legal") {
                Text("PawTrack is not a medical diagnostic tool.")
                Text("Always consult your veterinarian for clinical advice.")
            }
        }
        .navigationTitle("Settings")
    }
}
