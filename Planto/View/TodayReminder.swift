import SwiftUI
struct TodayReminder: View {
    @State private var showSheet = false
    
    @State private var selectedPlant: Plant? = nil
    
    @Bindable var viewModel: PlantsViewModel
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal)    // مسافة من اليمين واليسار
                    .padding(.top, 20)       // مسافة من فوق
                    .padding(.bottom, 12)    // مسافة بينه وبين الخط

                
                Divider()
                    .background(Color.gray)
                
                Text(viewModel.doneCount == 0
                      ? "Your plants are waiting for a sip 💦"
                      : "\(viewModel.doneCount) of your plants feel loved today✨")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 24)
                
                ProgressView(value: viewModel.plants.isEmpty ? 0 : Double(viewModel.doneCount) / Double(viewModel.plants.count))
                    .tint(Color(red: 0.24, green: 0.55, blue: 0.43))
                    .scaleEffect(x: 1, y: 2)     // يكبّر السماكة 3 أضعاف
                    .padding(.horizontal)
                    .padding(.top, 12)
                List {
                    ForEach($viewModel.plants) { $plant in
                        PlantRow(
                            room: plant.room.rawValue,
                            name: plant.name,
                            light: plant.light.rawValue,
                            water: plant.water.rawValue,
                            isDone: $plant.isWatered
                        )
                        .onTapGesture {
                            selectedPlant = plant
                        }
                        .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deletePlant(plant)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
                .listStyle(.plain)                  // قائمة بسيطة بدون كروت
                .scrollContentBackground(.hidden)   // نشيل خلفيتها الافتراضية
                .padding(.top, 20)                  // مسافة بينها وبين الشريط
            }.overlay(alignment: .bottomTrailing) {
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(Color(red: 0.24, green: 0.55, blue: 0.43))
                        .clipShape(Circle())
                }
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
            .sheet(isPresented: $showSheet) {
                SetReminderView(viewModel: viewModel)
            }
            .sheet(item: $selectedPlant) { plant in
                SetReminderView(viewModel: viewModel, plantToEdit: plant)
            }
            .overlay {
                if viewModel.allDone {
                    AllDone(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    let viewModel = PlantsViewModel()
    viewModel.plants = [
        Plant(name: "Monstera", room: .kitchen, light: .fullSun, wateringDays: .everyDay, water: .ml20to50),
        Plant(name: "Pothos", room: .bedroom, light: .fullSun, wateringDays: .every2Days, water: .ml50to100, isWatered: true)
    ]
    return TodayReminder(viewModel: viewModel)
}
