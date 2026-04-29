# Release Preparation Notes

## SwiftData Migration Strategy
- Track schema updates using additive-first changes for v1.
- Avoid destructive field removals without data backfill.
- Add migration tests before altering model fields with existing persisted data.

## TestFlight Prep
- Increment build number and version.
- Confirm notification usage descriptions in app metadata.
- Validate share/export behavior on physical device.
- Execute `docs/QA_CHECKLIST.md` before each beta cut.

## Residual Scope for v1+
- Cloud sync and multi-pet support are intentionally deferred.
- Advanced PDF styling can replace plain text PDF payload in a future iteration.
