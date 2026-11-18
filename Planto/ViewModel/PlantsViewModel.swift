import SwiftUI

@Observable
class PlantsViewModel {

    var plants: [Plant] = []
    var hasAddedBefore = false

    var doneCount: Int {
        plants.filter { $0.isWatered }.count
    }

    var allDone: Bool {
        !plants.isEmpty && doneCount == plants.count
    }

    func addPlant(name: String, room: Room, light: Light, wateringDays: WateringDays, water: Water) {
        let plant = Plant(name: name, room: room, light: light, wateringDays: wateringDays, water: water)
        plants.append(plant)
        hasAddedBefore = true
        NotificationManager.shared.schedule(for: plant)
    }

    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        NotificationManager.shared.cancel(for: plant)
    }

    func updatePlant(_ updated: Plant) {
        if let index = plants.firstIndex(where: { $0.id == updated.id }) {
            plants[index] = updated
            NotificationManager.shared.schedule(for: updated)
        }
    }
}
