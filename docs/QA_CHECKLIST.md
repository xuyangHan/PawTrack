# PawTrack QA Checklist

## Core Flows
- Launch app and verify onboarding appears on first run.
- Create a pet profile and confirm app routes to main tabs.
- Edit pet profile fields and verify values persist after relaunch.
- Add activity, food/water, medication, and weight entries.
- Delete each log type from logs list.

## Reports and Export
- Select 7-day and 30-day ranges in reports and verify metrics update.
- Export CSV and verify shared file contains expected columns.
- Export PDF and verify share sheet appears.

## Reminders
- Create reminder and verify local notification is scheduled.
- Mark reminder done and verify pending notification is cancelled.
- Verify repeat reminder supports repeat day values.

## Accessibility
- Test Dynamic Type at extra large text sizes.
- Run VoiceOver through home cards, forms, and tab bar labels.
- Verify contrast of primary text and buttons on background.

## Reliability
- Cold launch with empty database and with existing database.
- Enter invalid values in forms and verify user-facing validation errors.
- Verify app behavior if there is no report data in selected range.
