import SwiftUI

struct SetReminderView: View {
    var viewModel: PlantsViewModel
    var plantToEdit: Plant? = nil
    @Environment(\.dismiss) var dismiss

    @State private var plantName: String
    @State private var room: Room
    @State private var light: Light
    @State private var wateringDays: WateringDays
    @State private var water: Water

    init(viewModel: PlantsViewModel, plantToEdit: Plant? = nil) {
        self.viewModel = viewModel
        self.plantToEdit = plantToEdit
        _plantName = State(initialValue: plantToEdit?.name ?? "")
        _room = State(initialValue: plantToEdit?.room ?? .bedroom)
        _light = State(initialValue: plantToEdit?.light ?? .fullSun)
        _wateringDays = State(initialValue: plantToEdit?.wateringDays ?? .everyDay)
        _water = State(initialValue: plantToEdit?.water ?? .ml20to50)
    }

    var body: some View {

        ZStack {

            Color(white: 0.1).ignoresSafeArea()

            VStack(spacing: 10) {

                HStack {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .padding(12)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("Set Reminder")

                    Spacer()

                    Button {
                        if var plant = plantToEdit {
                            plant.name = plantName
                            plant.room = room
                            plant.light = light
                            plant.wateringDays = wateringDays
                            plant.water = water
                            viewModel.updatePlant(plant)
                        } else {
                            viewModel.addPlant(name: plantName, room: room, light: light,
                                               wateringDays: wateringDays, water: water)
                        }
                        dismiss()

                    } label: {
                        Image(systemName: "checkmark")
                            .padding(12)
                            .background(Color(red: 0.24, green: 0.55, blue: 0.43))
                            .clipShape(Circle())
                    }
                }
                .foregroundStyle(.white)
                .padding()

                HStack {
                    Text("Plant Name")
                        .foregroundStyle(.white)

                    TextField("Pothos", text: $plantName)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .clipShape(Capsule())
                .padding(.horizontal)

                VStack(spacing: 0) {
                    HStack {
                        Label("Room", systemImage: "location")
                        Spacer()
                        Picker("Room", selection: $room) {
                            ForEach(Room.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                        }
                        .labelsHidden()
                        .tint(.gray)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    Divider().padding(.leading, 16)
                    HStack {
                        Label("Light", systemImage: "sun.max")
                        Spacer()
                        Picker("Light", selection: $light) {
                            ForEach(Light.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                        }
                        .labelsHidden()
                        .tint(.gray)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                }
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .padding(.top, 10)

                VStack(spacing: 0) {
                    HStack {
                        Label("Watering Days", systemImage: "drop")
                        Spacer()
                        Picker("Watering Days", selection: $wateringDays) {
                            ForEach(WateringDays.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                        }
                        .labelsHidden()
                        .tint(.gray)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    Divider().padding(.leading, 16)
                    HStack {
                        Label("Water", systemImage: "drop")
                        Spacer()
                        Picker("Water", selection: $water) {
                            ForEach(Water.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                        }
                        .labelsHidden()
                        .tint(.gray)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                }
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .padding(.top, 10)
                .foregroundStyle(.white)

                if let plant = plantToEdit {
                    Button {
                        viewModel.deletePlant(plant)
                        dismiss()
                    } label: {
                        Text("Delete Reminder")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SetReminderView(viewModel: PlantsViewModel())
}
