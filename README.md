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

Key flows and screens are documented in `design/` with both static previews and HTML prototypes.

### Core pages

- **Welcome** - first-launch onboarding and app overview. [Preview](design/welcome_to_pawtrack/screen.png) | [Prototype](design/welcome_to_pawtrack/code.html)
- **Home Dashboard** - daily snapshot with quick access to logging actions. [Preview](design/home_dashboard/screen.png) | [Prototype](design/home_dashboard/code.html)
- **Unified Log Entry** - central entry point for adding health records quickly. [Preview](design/unified_log_entry/screen.png) | [Prototype](design/unified_log_entry/code.html)
- **Health Reports** - trend-focused summaries designed for vet discussions. [Preview](design/unified_health_reports/screen.png) | [Prototype](design/unified_health_reports/code.html)

### Log entry variants

- **New Activity Log** - symptom, behavior, and event-specific activity records. [Preview](design/new_activity_log/screen.png) | [Prototype](design/new_activity_log/code.html)
- **New Food/Water Log** - meal and hydration tracking with structured inputs. [Preview](design/new_food_water_log/screen.png) | [Prototype](design/new_food_water_log/code.html)
- **New Medication Log** - dosage, schedule, and medication adherence records. [Preview](design/new_medication_log/screen.png) | [Prototype](design/new_medication_log/code.html)

### Pet profile pages

- **Pet Profile** - high-level pet identity and profile overview. [Preview](design/pet_profile/screen.png) | [Prototype](design/pet_profile/code.html)
- **Pet Details** - deeper pet information including background and context. [Preview](design/pet_details/screen.png) | [Prototype](design/pet_details/code.html)
- **Pet Photo** - pet image selection and profile photo display. [Preview](design/pet_photo/screen.png) | [Prototype](design/pet_photo/code.html)

---

Built to make vet visits easier and more accurate 🐾
