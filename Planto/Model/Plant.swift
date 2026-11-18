import Foundation

enum Room: String, CaseIterable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

enum Light: String, CaseIterable {
    case fullSun = "Full sun"
    case partialSun = "Partial sun"
    case lowLight = "Low light"
}

enum WateringDays: String, CaseIterable {
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"
}

extension WateringDays {
    // كم يوم بين كل سقاية (نستخدمه للإشعار)
    var days: Int {
        switch self {
        case .everyDay: return 1
        case .every2Days: return 2
        case .every3Days: return 3
        case .onceAWeek: return 7
        case .every10Days: return 10
        case .every2Weeks: return 14
        }
    }
}

enum Water: String, CaseIterable {
    case ml20to50 = "20-50 ml"
    case ml50to100 = "50-100 ml"
    case ml100to200 = "100-200 ml"
    case ml200to300 = "200-300 ml"
}

struct Plant: Identifiable {
    let id = UUID()
    var name: String
    var room: Room
    var light: Light
    var wateringDays: WateringDays
    var water: Water
    var isWatered = false
}
