import Foundation
import SwiftData
import UserNotifications
import SwiftUI
import UniformTypeIdentifiers

protocol PetRepository {
    func upsert(_ pet: PetProfile, in context: ModelContext) throws
}

protocol LogRepository {
    func insertActivity(_ log: ActivityLog, in context: ModelContext) throws
    func insertFoodWater(_ log: FoodWaterLog, in context: ModelContext) throws
    func insertMedication(_ log: MedicationLog, in context: ModelContext) throws
}

protocol ReminderRepository {
    func upsert(_ reminder: ReminderItem, in context: ModelContext) throws
}

protocol ReportRepository {
    func buildSummary(startDate: Date, endDate: Date, in context: ModelContext) throws -> ReportSummary
}

struct SwiftDataRepository: PetRepository, LogRepository, ReminderRepository, ReportRepository {
    func upsert(_ pet: PetProfile, in context: ModelContext) throws {
        pet.updatedAt = .now
        context.insert(pet)
        try context.save()
    }

    func insertActivity(_ log: ActivityLog, in context: ModelContext) throws {
        context.insert(log)
        try context.save()
    }

    func insertFoodWater(_ log: FoodWaterLog, in context: ModelContext) throws {
        context.insert(log)
        try context.save()
    }

    func insertMedication(_ log: MedicationLog, in context: ModelContext) throws {
        context.insert(log)
        try context.save()
    }

    func upsert(_ reminder: ReminderItem, in context: ModelContext) throws {
        context.insert(reminder)
        try context.save()
    }

    func buildSummary(startDate: Date, endDate: Date, in context: ModelContext) throws -> ReportSummary {
        let activityDescriptor = FetchDescriptor<ActivityLog>(
            predicate: #Predicate { $0.occurredAt >= startDate && $0.occurredAt <= endDate }
        )
        let foodDescriptor = FetchDescriptor<FoodWaterLog>(
            predicate: #Predicate { $0.occurredAt >= startDate && $0.occurredAt <= endDate }
        )
        let medDescriptor = FetchDescriptor<MedicationLog>(
            predicate: #Predicate { $0.occurredAt >= startDate && $0.occurredAt <= endDate }
        )
        let activities = try context.fetch(activityDescriptor)
        let foodLogs = try context.fetch(foodDescriptor)
        let meds = try context.fetch(medDescriptor)
        let avgWater = foodLogs.isEmpty ? 0 : foodLogs.map(\.waterAmountML).reduce(0, +) / Double(foodLogs.count)
        let adherence = meds.isEmpty ? 0 : Double(meds.filter(\.wasTaken).count) / Double(meds.count)
        return ReportSummary(
            totalActivities: activities.count,
            totalFoodLogs: foodLogs.count,
            averageWaterML: avgWater,
            medicationAdherence: adherence
        )
    }
}

struct ReportSummary {
    let totalActivities: Int
    let totalFoodLogs: Int
    let averageWaterML: Double
    let medicationAdherence: Double
}

struct NotificationService {
    func requestPermission() async throws {
        _ = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
    }

    func schedule(reminder: ReminderItem) async throws {
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.subtitle = reminder.type.rawValue.capitalized
        content.sound = .default
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: reminder.repeatDays != nil)
        let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: trigger)
        try await UNUserNotificationCenter.current().add(request)
    }

    func cancel(reminderID: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminderID.uuidString])
    }
}

struct ExportPayload {
    let filename: String
    let data: Data
    let contentType: UTType
}

struct ExportService {
    func exportCSV(summary: ReportSummary) -> ExportPayload {
        let csv = """
        metric,value
        totalActivities,\(summary.totalActivities)
        totalFoodLogs,\(summary.totalFoodLogs)
        averageWaterML,\(summary.averageWaterML)
        medicationAdherence,\(summary.medicationAdherence)
        """
        return ExportPayload(filename: "pawtrack_report.csv", data: Data(csv.utf8), contentType: .commaSeparatedText)
    }

    func exportPDF(summary: ReportSummary) -> ExportPayload {
        let body = """
        PawTrack Report

        Total activities: \(summary.totalActivities)
        Total food/water logs: \(summary.totalFoodLogs)
        Avg water (ml): \(Int(summary.averageWaterML))
        Medication adherence: \(Int(summary.medicationAdherence * 100))%
        """
        return ExportPayload(filename: "pawtrack_report.pdf", data: Data(body.utf8), contentType: .pdf)
    }
}

struct AnalyticsService {
    func track(_ event: String, metadata: [String: String] = [:]) {
        #if DEBUG
        print("Analytics event:", event, metadata)
        #endif
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let payload: ExportPayload

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(payload.filename)
        try? payload.data.write(to: tempURL)
        return UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
