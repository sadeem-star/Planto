# Planto 🌱

Planto is an iOS app that helps you remember to water your plants. Add your plants, choose how often each one needs water, and get a reminder when it's time.

## Features

- Add a plant with its name, room, light, watering days and water amount
- Mark each plant as watered, with a progress bar showing how many are done today
- "All Done!" screen when every plant has been watered
- Tap a plant to edit it, or swipe to delete it
- Local notification reminders based on each plant's watering schedule

## Built with

- Swift and SwiftUI
- MVVM architecture (using the Observation framework)
- UserNotifications for reminders

## Project structure

```
Planto/
├── Model/        Plant and its options (Room, Light, WateringDays, Water)
├── View/         The screens (Homepage, TodayReminder, SetReminder, AllDone, ...)
└── ViewModel/    PlantsViewModel and NotificationManager
```

## How to run

1. Open `Planto.xcodeproj` in Xcode (the one inside the inner `Planto` folder)
2. Choose an iPhone simulator or your own iPhone
3. Press **Cmd + R**
4. Allow notifications when asked

## Design

The screens follow a high-fidelity design made in Sketch.

## Author

Sadeem Alghamdi
