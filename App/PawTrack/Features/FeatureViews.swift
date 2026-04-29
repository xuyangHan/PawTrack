import SwiftUI
import SwiftData
import Charts
import PhotosUI

struct OnboardingWelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: AppSpacing.cardGap) {
                Spacer()
                Text("Welcome to PawTrack")
                    .font(.appDisplay)
                Text("Track your pet's health, meals, symptoms, and reminders in one place.")
                    .font(.appBody)
                    .foregroundStyle(AppTheme.textSecondary)
                NavigationLink {
                    PetProfileEditorView(existingProfile: nil)
                } label: {
                    PrimaryButton(title: "Set Up Pet Profile", action: {})
                }
                Spacer()
            }
            .padding(AppSpacing.page)
            .background(AppTheme.background.ignoresSafeArea())
        }
    }
}

struct HomeDashboardView: View {
    @Query private var activityLogs: [ActivityLog]
    @Query private var foodLogs: [FoodWaterLog]
    @Query private var weightEntries: [WeightEntry]
    @Query(filter: #Predicate<ReminderItem> { !$0.isDone }, sort: \ReminderItem.dueDate) private var reminders: [ReminderItem]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.cardGap) {
                SectionHeader(title: "Daily Snapshot", subtitle: "Your pet's health at a glance")
                CardView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Today logs: \(activityLogs.count + foodLogs.count)")
                        Text("Latest weight: \(String(format: "%.1f", weightEntries.last?.kilograms ?? 0)) kg")
                        Text("Upcoming reminders: \(reminders.prefix(3).count)")
                    }
                    .font(.appBody)
                }
                UnifiedLogEntryHubView()
                WeightTrendMiniView(entries: weightEntries)
            }
            .padding(AppSpacing.page)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Home")
    }
}

struct UnifiedLogEntryHubView: View {
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Quick Log Entry")
                    .font(.appHeadline)
                NavigationLink("New Activity Log") { ActivityLogFormView() }
                NavigationLink("New Food/Water Log") { FoodWaterLogFormView() }
                NavigationLink("New Medication Log") { MedicationLogFormView() }
                NavigationLink("New Weight Entry") { WeightEntryFormView() }
            }
        }
    }
}

struct LogsListView: View {
    @State private var selectedCategory: LogCategory? = nil
    @Query private var activityLogs: [ActivityLog]
    @Query private var foodLogs: [FoodWaterLog]
    @Query private var medicationLogs: [MedicationLog]

    var body: some View {
        List {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach([nil] + LogCategory.allCases.map(Optional.some), id: \.self) { category in
                        TagChip(
                            title: category?.rawValue.capitalized ?? "All",
                            isSelected: selectedCategory == category
                        )
                        .onTapGesture { selectedCategory = category }
                    }
                }
            }
            .listRowBackground(Color.clear)

            if selectedCategory == nil || selectedCategory == .activity {
                Section("Activity") {
                    ForEach(activityLogs) { log in
                        Text("\(log.symptom) (sev \(log.severity))")
                    }
                    .onDelete(perform: deleteActivity)
                }
            }
            if selectedCategory == nil || selectedCategory == .foodWater {
                Section("Food/Water") {
                    ForEach(foodLogs) { log in
                        Text("\(log.mealType.rawValue.capitalized): \(Int(log.foodAmountGrams))g / \(Int(log.waterAmountML))ml")
                    }
                    .onDelete(perform: deleteFood)
                }
            }
            if selectedCategory == nil || selectedCategory == .medication {
                Section("Medication") {
                    ForEach(medicationLogs) { log in
                        Text("\(log.medicineName) \(log.doseAmount, specifier: "%.1f")\(log.doseUnit.rawValue)")
                    }
                    .onDelete(perform: deleteMedication)
                }
            }
        }
        .navigationTitle("Logs")
        .toolbar {
            Menu("Add") {
                NavigationLink("Activity", destination: ActivityLogFormView())
                NavigationLink("Food/Water", destination: FoodWaterLogFormView())
                NavigationLink("Medication", destination: MedicationLogFormView())
            }
        }
    }

    @Environment(\.modelContext) private var modelContext
    private func deleteActivity(at offsets: IndexSet) {
        for index in offsets { modelContext.delete(activityLogs[index]) }
        try? modelContext.save()
    }
    private func deleteFood(at offsets: IndexSet) {
        for index in offsets { modelContext.delete(foodLogs[index]) }
        try? modelContext.save()
    }
    private func deleteMedication(at offsets: IndexSet) {
        for index in offsets { modelContext.delete(medicationLogs[index]) }
        try? modelContext.save()
    }
}

struct ActivityLogFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var symptom = ""
    @State private var severity = 1
    @State private var occurredAt = Date()
    @State private var notes = ""
    @State private var errorMessage: String?

    var body: some View {
        Form {
            AppTextField(title: "Symptom/Behavior", text: $symptom)
            Stepper("Severity: \(severity)", value: $severity, in: 1...5)
            DatePicker("Time", selection: $occurredAt)
            TextField("Notes", text: $notes, axis: .vertical)
            if let errorMessage { Text(errorMessage).foregroundStyle(.red) }
            Button("Save") { save() }
        }
        .navigationTitle("New Activity Log")
    }

    private func save() {
        guard !symptom.isEmpty else { errorMessage = "Symptom is required"; return }
        let log = ActivityLog(occurredAt: occurredAt, symptom: symptom, severity: severity, notes: notes)
        modelContext.insert(log)
        try? modelContext.save()
        dismiss()
    }
}

struct FoodWaterLogFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var mealType: MealType = .breakfast
    @State private var foodAmount = 0.0
    @State private var waterAmount = 0.0
    @State private var occurredAt = Date()
    @State private var notes = ""
    @State private var errorMessage: String?

    var body: some View {
        Form {
            Picker("Meal Type", selection: $mealType) {
                ForEach(MealType.allCases) { Text($0.rawValue.capitalized).tag($0) }
            }
            TextField("Food (g)", value: $foodAmount, format: .number)
                .keyboardType(.decimalPad)
            TextField("Water (ml)", value: $waterAmount, format: .number)
                .keyboardType(.decimalPad)
            DatePicker("Time", selection: $occurredAt)
            TextField("Notes", text: $notes, axis: .vertical)
            if let errorMessage { Text(errorMessage).foregroundStyle(.red) }
            Button("Save") { save() }
        }
        .navigationTitle("New Food/Water Log")
    }

    private func save() {
        do {
            try DomainValidator.validateFood(foodAmount, waterAmount)
            let log = FoodWaterLog(occurredAt: occurredAt, mealType: mealType, foodAmountGrams: foodAmount, waterAmountML: waterAmount, notes: notes)
            modelContext.insert(log)
            try modelContext.save()
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct MedicationLogFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var medicineName = ""
    @State private var doseAmount = 1.0
    @State private var doseUnit: DoseUnit = .tablet
    @State private var occurredAt = Date()
    @State private var wasTaken = true
    @State private var notes = ""
    @State private var errorMessage: String?

    var body: some View {
        Form {
            AppTextField(title: "Medication", text: $medicineName)
            TextField("Dose", value: $doseAmount, format: .number)
                .keyboardType(.decimalPad)
            Picker("Unit", selection: $doseUnit) {
                ForEach(DoseUnit.allCases) { Text($0.rawValue.uppercased()).tag($0) }
            }
            Toggle("Taken", isOn: $wasTaken)
            DatePicker("Time", selection: $occurredAt)
            TextField("Notes", text: $notes, axis: .vertical)
            if let errorMessage { Text(errorMessage).foregroundStyle(.red) }
            Button("Save") { save() }
        }
        .navigationTitle("New Medication Log")
    }

    private func save() {
        do {
            try DomainValidator.validateMedication(dose: doseAmount, occurredAt: occurredAt)
            let log = MedicationLog(occurredAt: occurredAt, medicineName: medicineName, doseAmount: doseAmount, doseUnit: doseUnit, wasTaken: wasTaken, notes: notes)
            modelContext.insert(log)
            try modelContext.save()
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct WeightEntryFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var kilograms = 0.0
    @State private var notes = ""
    @State private var errorMessage: String?

    var body: some View {
        Form {
            TextField("Weight (kg)", value: $kilograms, format: .number)
                .keyboardType(.decimalPad)
            TextField("Notes", text: $notes, axis: .vertical)
            if let errorMessage { Text(errorMessage).foregroundStyle(.red) }
            Button("Save") { save() }
        }
        .navigationTitle("New Weight Entry")
    }

    private func save() {
        do {
            try DomainValidator.validateWeight(kilograms)
            modelContext.insert(WeightEntry(recordedAt: .now, kilograms: kilograms, notes: notes))
            try modelContext.save()
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct WeightTrendMiniView: View {
    let entries: [WeightEntry]
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Weight Trend")
                    .font(.appHeadline)
                if entries.isEmpty {
                    Text("No entries yet.")
                } else {
                    Chart(entries.sorted { $0.recordedAt < $1.recordedAt }.suffix(7)) { entry in
                        LineMark(x: .value("Date", entry.recordedAt), y: .value("kg", entry.kilograms))
                    }
                    .frame(height: 120)
                }
            }
        }
    }
}

struct PetProfileView: View {
    @Query private var pets: [PetProfile]

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.cardGap) {
            if let pet = pets.first {
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(pet.name).font(.appHeadline)
                        Text("\(pet.species) · \(pet.breed)")
                        Text("Medical notes: \(pet.medicalInfo.isEmpty ? "None" : pet.medicalInfo)")
                    }
                }
                NavigationLink("Edit Profile") {
                    PetProfileEditorView(existingProfile: pet)
                }
                NavigationLink("Reminders") {
                    RemindersView()
                }
                NavigationLink("Settings & Legal") {
                    SettingsAndLegalView()
                }
            } else {
                Text("No pet profile yet.")
                NavigationLink("Create Profile") {
                    PetProfileEditorView(existingProfile: nil)
                }
                NavigationLink("Settings & Legal") {
                    SettingsAndLegalView()
                }
            }
            Spacer()
        }
        .padding(AppSpacing.page)
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Pet Profile")
    }
}

struct PetProfileEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let existingProfile: PetProfile?
    @State private var name = ""
    @State private var species = ""
    @State private var breed = ""
    @State private var birthDate = Date()
    @State private var medicalInfo = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photoData: Data?
    @State private var errorMessage: String?

    var body: some View {
        Form {
            AppTextField(title: "Name", text: $name)
            AppTextField(title: "Species", text: $species)
            AppTextField(title: "Breed", text: $breed)
            DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
            TextField("Medical info", text: $medicalInfo, axis: .vertical)
            PhotosPicker(selection: $photoItem, matching: .images) {
                Text("Select Profile Photo")
            }
            if let photoData, let image = UIImage(data: photoData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            if let errorMessage { Text(errorMessage).foregroundStyle(.red) }
            Button(existingProfile == nil ? "Create Profile" : "Save Changes") {
                save()
            }
        }
        .task(id: photoItem) {
            photoData = try? await photoItem?.loadTransferable(type: Data.self)
        }
        .onAppear(perform: populateIfNeeded)
        .navigationTitle(existingProfile == nil ? "Create Profile" : "Edit Profile")
    }

    private func populateIfNeeded() {
        guard let pet = existingProfile else { return }
        name = pet.name
        species = pet.species
        breed = pet.breed
        birthDate = pet.birthDate
        medicalInfo = pet.medicalInfo
        photoData = pet.photoData
    }

    private func save() {
        do {
            try DomainValidator.validatePet(name: name, species: species)
            if let pet = existingProfile {
                pet.name = name
                pet.species = species
                pet.breed = breed
                pet.birthDate = birthDate
                pet.medicalInfo = medicalInfo
                pet.photoData = photoData
                pet.updatedAt = .now
            } else {
                modelContext.insert(PetProfile(name: name, species: species, breed: breed, birthDate: birthDate, medicalInfo: medicalInfo, photoData: photoData))
            }
            try modelContext.save()
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

struct HealthReportsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.appContainer) private var container
    @State private var startDate = Calendar.current.date(byAdding: .day, value: -7, to: .now) ?? .now
    @State private var endDate = Date()
    @State private var summary = ReportSummary(totalActivities: 0, totalFoodLogs: 0, averageWaterML: 0, medicationAdherence: 0)
    @State private var showShare = false
    @State private var exportPayload: ExportPayload?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.cardGap) {
                SectionHeader(title: "Health Reports", subtitle: "Vet-ready summaries")
                CardView {
                    VStack(alignment: .leading, spacing: 12) {
                        DatePicker("Start", selection: $startDate, displayedComponents: .date)
                        DatePicker("End", selection: $endDate, displayedComponents: .date)
                        Button("Refresh") { refreshSummary() }
                    }
                }
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Activities: \(summary.totalActivities)")
                        Text("Food/Water logs: \(summary.totalFoodLogs)")
                        Text("Average water: \(Int(summary.averageWaterML)) ml")
                        Text("Medication adherence: \(Int(summary.medicationAdherence * 100))%")
                    }
                }
                HStack {
                    PrimaryButton(title: "Export CSV") { exportCSV() }
                    PrimaryButton(title: "Export PDF") { exportPDF() }
                }
            }
            .padding(AppSpacing.page)
        }
        .onAppear(perform: refreshSummary)
        .sheet(isPresented: $showShare) {
            if let exportPayload {
                ShareSheet(payload: exportPayload)
            }
        }
        .navigationTitle("Reports")
    }

    private func refreshSummary() {
        let repo = SwiftDataRepository()
        summary = (try? repo.buildSummary(startDate: startDate, endDate: endDate, in: modelContext))
            ?? ReportSummary(totalActivities: 0, totalFoodLogs: 0, averageWaterML: 0, medicationAdherence: 0)
    }

    private func exportCSV() {
        exportPayload = container.exportService.exportCSV(summary: summary)
        showShare = true
    }

    private func exportPDF() {
        exportPayload = container.exportService.exportPDF(summary: summary)
        showShare = true
    }
}

struct RemindersView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.appContainer) private var container
    @Query(sort: \ReminderItem.dueDate) private var reminders: [ReminderItem]
    @State private var title = ""
    @State private var type: ReminderType = .vetVisit
    @State private var dueDate = Date()
    @State private var repeatEveryDays = 0

    var body: some View {
        Form {
            Section("New Reminder") {
                AppTextField(title: "Title", text: $title)
                Picker("Type", selection: $type) {
                    ForEach(ReminderType.allCases) { Text($0.rawValue.capitalized).tag($0) }
                }
                DatePicker("Due", selection: $dueDate)
                Stepper("Repeat every \(repeatEveryDays) days", value: $repeatEveryDays, in: 0...60)
                Button("Add Reminder") { addReminder() }
            }

            Section("Upcoming") {
                ForEach(reminders) { reminder in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(reminder.title)
                            Text(reminder.dueDate.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button(reminder.isDone ? "Done" : "Mark Done") {
                            reminder.isDone = true
                            try? modelContext.save()
                            container.notificationService.cancel(reminderID: reminder.id)
                        }
                    }
                }
            }
        }
        .navigationTitle("Reminders")
        .task {
            try? await container.notificationService.requestPermission()
        }
    }

    private func addReminder() {
        let reminder = ReminderItem(
            title: title,
            type: type,
            dueDate: dueDate,
            repeatDays: repeatEveryDays == 0 ? nil : repeatEveryDays
        )
        modelContext.insert(reminder)
        try? modelContext.save()
        Task { try? await container.notificationService.schedule(reminder: reminder) }
        title = ""
    }
}
