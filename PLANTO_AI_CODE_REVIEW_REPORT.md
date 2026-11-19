# Planto — AI Code Review Report

**Repository:** [sadeem-star/Planto](https://github.com/sadeem-star/Planto)  
**Review date:** 2026-11-19  
**Challenge:** Hello World Challenge  
**Primary language:** Swift (23,345 bytes)  
**Overall assessment:** 7.5/10 — good visual implementation and clear MVVM structure, with important persistence and reminder-behavior gaps.

## Executive summary

Planto is a focused iOS plant-watering reminder app built with SwiftUI and the Observation framework. The repository shows a coherent feature set: create, edit, delete, mark plants as watered, display progress, and schedule local notifications.

The strongest areas are feature completeness, readable enums, SwiftUI navigation/state handling, and the separation of views, models, and view models. The main weakness is that application state is entirely in memory: closing or reinstalling the app loses every plant and watering status. Notification behavior is also not synchronized with “mark as watered,” and the form does not validate a plant name.

## Architecture and implementation

- **UI:** SwiftUI
- **Architecture:** MVVM using `@Observable`
- **Data model:** in-memory `[Plant]` collection
- **Notifications:** `UserNotifications`
- **Navigation/state:** `RootView`, sheets, bindings, and `@Bindable`

Source areas reviewed:

- [README.md](https://github.com/sadeem-star/Planto/blob/main/README.md)
- [RootView.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/RootView.swift)
- [PlantsViewModel.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/ViewModel/PlantsViewModel.swift)
- [Plant.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/Model/Plant.swift)
- [Set Reminder.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/Set%20Reminder.swift)
- [TodayReminder.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/TodayReminder.swift)
- [NotificationManager.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/ViewModel/NotificationManager.swift)

## Findings

### 1. High — Plant data is not persisted

**Where:** [PlantsViewModel.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/ViewModel/PlantsViewModel.swift#L4-L7)

`plants` begins as an empty array and is only held in memory. After app termination or restart, all plants and watered statuses are lost.

**Recommendation:** Adopt SwiftData or `Codable` plus `UserDefaults` for the challenge scope. SwiftData is the stronger fit for a data-rich iOS app. Load saved plants during initialization and save changes transactionally.

### 2. High — Watered actions do not reset or reschedule reminders

**Where:** [PlantRow.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/PlantRow.swift#L12-L18), [PlantsViewModel.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/ViewModel/PlantsViewModel.swift#L9-L14), [NotificationManager.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/ViewModel/NotificationManager.swift#L21-L37)

Marking a plant as watered only toggles `isWatered`. It does not record the watering date or move the next notification forward by the selected interval.

**Recommendation:** Store `lastWateredAt` and calculate the next watering date. When watered, cancel or replace the pending notification and schedule it for the next expected date. Reset `isWatered` at the start of a new day based on dates rather than retaining it indefinitely.

### 3. Medium — Empty or whitespace-only plant names are accepted

**Where:** [Set Reminder.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/Set%20Reminder.swift#L49-L60)

The checkmark allows creation even when `plantName` is empty or whitespace.

**Recommendation:** Trim whitespace before saving and disable the checkmark unless `plantName` contains meaningful text. Return focus and present inline validation if submission fails.

### 4. Medium — Notification authorization status and failures are not surfaced

**Where:** [NotificationManager.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/ViewModel/NotificationManager.swift#L15-L18), [RootView.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/RootView.swift#L15-L17)

Authorization and scheduling closures discard errors, and permission is requested on every appearance.

**Recommendation:** Add an authorization state, handle denied status, and explain how to enable notifications in Settings. Use scheduling completion handlers to detect and report failures. Avoid relying on automatic permission prompts during unrelated app launches.

### 5. Medium — Saved plants are not recovered into notification scheduling

**Where:** [PlantsViewModel.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/ViewModel/PlantsViewModel.swift)

Even if persistence is added later, notifications must be reconciled on launch to restore or replace pending requests. The current app has no launch reconciliation step.

**Recommendation:** On app launch, load plants, remove stale pending requests, and schedule the next reminder for each plant based on persisted watering dates.

### 6. Low — State-changing controls need clearer accessibility labels

**Where:** [PlantRow.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/PlantRow.swift#L12-L18), [Set Reminder.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/Set%20Reminder.swift#L32-L68)

The icon-only close, save, add, and delete controls rely on symbols. The watered toggle is attached to a small tap area and not exposed as a labeled control.

**Recommendation:** Use SwiftUI `Button` semantics, `.accessibilityLabel`, `.accessibilityHint`, and `.accessibilityValue(isDone ? "Watered" : "Not watered")`. Increase the toggle hit target and make labels localized.

### 7. Low — Dark-only design and hard-coded colors reduce flexibility

**Where:** [TodayReminder.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/TodayReminder.swift), [PlantRow.swift](https://github.com/sadeem-star/Planto/blob/main/Planto/View/PlantRow.swift)

Several `.foregroundStyle`, `.background`, and RGB values are duplicated throughout the views.

**Recommendation:** Define semantic colors in the asset catalog and use `@Environment`/dynamic colors for contrast and light-mode adaptation.

## Positive observations

- Clear three-layer organization: Model, View, and ViewModel.
- Useful enums keep room, light, watering, and water options type-safe.
- The app implements the complete reminder workflow rather than stopping at a static mockup.
- The root flow is intuitive: onboarding, active plants, no-reminders state, and all-done state.
- Notification identifiers use a plant UUID, and updates replace the same scheduled request.
- Preview data and `#Preview` annotations improve local SwiftUI iteration.
- README includes setup instructions and an accurate architecture overview.

## Testing and quality gaps

No test target or test files were visible in the reviewed repository. Recommended coverage:

1. Add/edit/delete plant behavior.
2. Progress and all-done calculations.
3. Empty, whitespace, and duplicate-name validation.
4. Last-watered date and next-reminder calculation.
5. Notification scheduling and cancellation.
6. Persistence across app launch and process termination.
7. Denied and restricted notification permissions.

## Recommended priority plan

### Before submission

- Persist plants and watered state.
- Validate and trim plant names.
- Disable save while invalid.
- Add accessible labels to icon-only controls.
- Handle notification authorization and scheduling failures.

### For the next iteration

- Add SwiftData or Core Data migration considerations.
- Track last-watered dates and reset status by calendar day.
- Reconcile notifications after launch.
- Add unit tests for view-model and date logic.
- Centralize colors and typography.

## Final verdict

Planto demonstrates strong progress for a challenge submission: the app is complete enough to demonstrate a coherent plant-care concept and uses relevant iOS APIs. The highest-impact improvement is persistence, followed by date-aware watering behavior and notification reconciliation. With those additions, the app would move beyond an attractive prototype and behave as a dependable everyday reminder tool.

**Suggested challenge score:** 7.5/10

- **Concept and usefulness:** 9/10
- **Visual implementation:** 8/10
- **SwiftUI code quality:** 8/10
- **Architecture:** 8/10
- **Feature completeness:** 8/10
- **Data persistence:** 3/10
- **Notifications:** 6/10
- **Testing:** 2/10
