# PawTrack 🐾

PawTrack is a simple iOS app for tracking pet health and daily activities, designed to help pet owners provide accurate, structured information to veterinarians.

## ✨ Features

* 🐱 Pet profile management (breed, age, medical info, photo)
* ⚖️ Weight tracking with time-series history
* 📝 Activity logging (e.g. vomiting, stool condition, behavior)
* 🍽️ Food & water intake tracking
* ⏰ Reminders for vet visits and vaccinations
* 📊 Exportable reports for vet visits (date-range based)

## 🎯 Goal

Pet owners often rely on memory when describing symptoms to vets. PawTrack aims to replace guesswork with structured, reliable data.

## 🛠 Tech Stack 

* SwiftUI
* SwiftData / CoreData
* Local Notifications
* PDF / CSV export

## Design

Key flows and screens are shown below from the generated design previews.

### Core pages

- **Welcome** - first-launch onboarding and app overview.  
  ![Welcome screen](design/welcome_to_pawtrack/screen.png)
- **Home Dashboard** - daily snapshot with quick access to logging actions.  
  ![Home dashboard screen](design/home_dashboard/screen.png)
- **Unified Log Entry** - central entry point for adding health records quickly.  
  ![Unified log entry screen](design/unified_log_entry/screen.png)
- **Health Reports** - trend-focused summaries designed for vet discussions.  
  ![Health reports screen](design/unified_health_reports/screen.png)

### Log entry variants

- **New Activity Log** - symptom, behavior, and event-specific activity records.  
  ![New activity log screen](design/new_activity_log/screen.png)
- **New Food/Water Log** - meal and hydration tracking with structured inputs.  
  ![New food and water log screen](design/new_food_water_log/screen.png)
- **New Medication Log** - dosage, schedule, and medication adherence records.  
  ![New medication log screen](design/new_medication_log/screen.png)

### Pet profile pages

- **Pet Profile** - high-level pet identity and profile overview.  
  ![Pet profile screen](design/pet_profile/screen.png)
- **Pet Details** - deeper pet information including background and context.  
  ![Pet details screen](design/pet_details/screen.png)
- **Pet Photo** - pet image selection and profile photo display.  
  ![Pet photo screen](design/pet_photo/screen.png)

---

Built to make vet visits easier and more accurate 🐾
