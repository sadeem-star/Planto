import SwiftUI

@Observable
class PlantsViewModel {

    var plants: [Plant] = []
    var hasAddedBefore = false
    
        
    var doneCount: Int {
        plants.filter { $0.isDone }.count
    }

    var allDone: Bool {
        !plants.isEmpty && doneCount == plants.count
    }
    func addPlant(name: String) {
        let plant = Plant(room: "Bedroom", name: name, light: "Full sun", water: "20-50 ml")
        plants.append(plant)
        hasAddedBefore = true
    }
    
    func deletePlant(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }
    func updatePlant(_ plant: Plant, name: String) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].name = name
        }
    }
}
