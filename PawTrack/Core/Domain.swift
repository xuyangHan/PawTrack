import Foundation
import SwiftData

enum LogCategory: String, Codable, CaseIterable, Identifiable {
    case activity
    case foodWater
    case medication
    var id: String { rawValue }
}

enum StoolCondition: String, Codable, CaseIterable, Identifiable {
    case normal, soft, diarrhea, constipated
    var id: String { rawValue }
}

enum BehaviorTag: String, Codable, CaseIterable, Identifiable {
    case playful, lethargic, anxious, aggressive, calm
    var id: String { rawValue }
}

enum MealType: String, Codable, CaseIterable, Identifiable {
    case breakfast, lunch, dinner, snack
    var id: String { rawValue }
}

enum DoseUnit: String, Codable, CaseIterable, Identifiable {
    case mg, ml, tablet
    var id: String { rawValue }
}

enum ReminderType: String, Codable, CaseIterable, Identifiable {
    case vetVisit, vaccination, medication
    var id: String { rawValue }
}

@Model
final class PetProfile {
    @Attribute(.unique) var id: UUID
    var name: String
    var species: String
    var breed: String
    var birthDate: Date
    var medicalInfo: String
    var photoData: Data?
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        species: String,
        breed: String,
        birthDate: Date,
        medicalInfo: String = "",
        photoData: Data? = nil,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.species = species
        self.breed = breed
        self.birthDate = birthDate
        self.medicalInfo = medicalInfo
        self.photoData = photoData
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

@Model
final class ActivityLog {
    @Attribute(.unique) var id: UUID
    var occurredAt: Date
    var symptom: String
    var severity: Int
    var stoolCondition: StoolCondition?
    var behaviorTag: BehaviorTag?
    var notes: String
    var createdAt: Date

    init(id: UUID = UUID(), occurredAt: Date, symptom: String, severity: Int, stoolCondition: StoolCondition? = nil, behaviorTag: BehaviorTag? = nil, notes: String = "", createdAt: Date = .now) {
        self.id = id
        self.occurredAt = occurredAt
        self.symptom = symptom
        self.severity = severity
        self.stoolCondition = stoolCondition
        self.behaviorTag = behaviorTag
        self.notes = notes
        self.createdAt = createdAt
    }
}

@Model
final class FoodWaterLog {
    @Attribute(.unique) var id: UUID
    var occurredAt: Date
    var mealType: MealType
    var foodAmountGrams: Double
    var waterAmountML: Double
    var notes: String
    var createdAt: Date

    init(id: UUID = UUID(), occurredAt: Date, mealType: MealType, foodAmountGrams: Double, waterAmountML: Double, notes: String = "", createdAt: Date = .now) {
        self.id = id
        self.occurredAt = occurredAt
        self.mealType = mealType
        self.foodAmountGrams = foodAmountGrams
        self.waterAmountML = waterAmountML
        self.notes = notes
        self.createdAt = createdAt
    }
}

@Model
final class MedicationLog {
    @Attribute(.unique) var id: UUID
    var occurredAt: Date
    var medicineName: String
    var doseAmount: Double
    var doseUnit: DoseUnit
    var wasTaken: Bool
    var notes: String
    var createdAt: Date

    init(id: UUID = UUID(), occurredAt: Date, medicineName: String, doseAmount: Double, doseUnit: DoseUnit, wasTaken: Bool, notes: String = "", createdAt: Date = .now) {
        self.id = id
        self.occurredAt = occurredAt
        self.medicineName = medicineName
        self.doseAmount = doseAmount
        self.doseUnit = doseUnit
        self.wasTaken = wasTaken
        self.notes = notes
        self.createdAt = createdAt
    }
}

@Model
final class WeightEntry {
    @Attribute(.unique) var id: UUID
    var recordedAt: Date
    var kilograms: Double
    var notes: String

    init(id: UUID = UUID(), recordedAt: Date, kilograms: Double, notes: String = "") {
        self.id = id
        self.recordedAt = recordedAt
        self.kilograms = kilograms
        self.notes = notes
    }
}

@Model
final class ReminderItem {
    @Attribute(.unique) var id: UUID
    var title: String
    var type: ReminderType
    var dueDate: Date
    var repeatDays: Int?
    var isDone: Bool
    var createdAt: Date

    init(id: UUID = UUID(), title: String, type: ReminderType, dueDate: Date, repeatDays: Int? = nil, isDone: Bool = false, createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.type = type
        self.dueDate = dueDate
        self.repeatDays = repeatDays
        self.isDone = isDone
        self.createdAt = createdAt
    }
}

enum DomainValidationError: Error, LocalizedError {
    case requiredField(String)
    case invalidRange(String)
    case invalidDate(String)

    var errorDescription: String? {
        switch self {
        case .requiredField(let field):
            return "\(field) is required."
        case .invalidRange(let field):
            return "\(field) is out of range."
        case .invalidDate(let message):
            return message
        }
    }
}

enum DomainValidator {
    static func validatePet(name: String, species: String) throws {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { throw DomainValidationError.requiredField("Pet name") }
        if species.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { throw DomainValidationError.requiredField("Species") }
    }

    static func validateWeight(_ kilograms: Double) throws {
        if kilograms <= 0 || kilograms > 200 { throw DomainValidationError.invalidRange("Weight") }
    }

    static func validateFood(_ grams: Double, _ waterML: Double) throws {
        if grams < 0 || grams > 5000 { throw DomainValidationError.invalidRange("Food amount") }
        if waterML < 0 || waterML > 10000 { throw DomainValidationError.invalidRange("Water amount") }
    }

    static func validateMedication(dose: Double, occurredAt: Date) throws {
        if dose <= 0 || dose > 10000 { throw DomainValidationError.invalidRange("Dose") }
        if occurredAt > .now.addingTimeInterval(3600) { throw DomainValidationError.invalidDate("Medication log cannot be in the far future.") }
    }
}
