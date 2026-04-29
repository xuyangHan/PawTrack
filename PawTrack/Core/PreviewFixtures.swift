import Foundation

enum PreviewFixtures {
    static let pet = PetProfile(
        name: "Milo",
        species: "Cat",
        breed: "Domestic Shorthair",
        birthDate: Calendar.current.date(byAdding: .year, value: -4, to: .now) ?? .now,
        medicalInfo: "Sensitive stomach."
    )

    static let activity = ActivityLog(
        occurredAt: .now.addingTimeInterval(-3600),
        symptom: "Vomiting",
        severity: 2,
        stoolCondition: .soft,
        behaviorTag: .lethargic,
        notes: "After breakfast."
    )

    static let food = FoodWaterLog(
        occurredAt: .now.addingTimeInterval(-1800),
        mealType: .breakfast,
        foodAmountGrams: 70,
        waterAmountML: 120
    )

    static let medication = MedicationLog(
        occurredAt: .now,
        medicineName: "Probiotic",
        doseAmount: 1,
        doseUnit: .tablet,
        wasTaken: true
    )

    static let weight = WeightEntry(recordedAt: .now.addingTimeInterval(-86400), kilograms: 4.8)
    static let reminder = ReminderItem(title: "Vet checkup", type: .vetVisit, dueDate: .now.addingTimeInterval(86400 * 5))
}
