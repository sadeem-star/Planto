import SwiftUI
struct Plant: Identifiable {
    let id = UUID()
    var room: String
    var name: String
    var light: String
    var water: String
    var isDone = false
}

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
                
                ProgressView(value: Double(viewModel.doneCount) / Double(viewModel.plants.count))
                    .tint(Color(red: 0.24, green: 0.55, blue: 0.43))
                    .scaleEffect(x: 1, y: 2)     // يكبّر السماكة 3 أضعاف
                    .padding(.horizontal)
                    .padding(.top, 12)
                List {
                    ForEach($viewModel.plants) { $plant in
                        PlantRow(
                            room: plant.room,
                            name: plant.name,
                            light: plant.light,
                            water: plant.water,
                            isDone: $plant.isDone
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
                    AllDone()
                }
            }
        }
    }
}


struct PlantRow: View {
    let room: String
    let name: String
    let light: String
    let water: String
    @Binding var isDone: Bool

    var body: some View {
        HStack(spacing: 16) {

            Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 28))
                .foregroundStyle(isDone ? Color(red: 0.24, green: 0.8, blue: 0.55) : .gray)
                .onTapGesture {
                        isDone.toggle()          // يقلب القيمة
                    }

            VStack(alignment: .leading, spacing: 6) {

                Label("in \(room)", systemImage: "location")
                    .font(.footnote)
                    .foregroundStyle(.gray)

                Text(name)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(.white)

                HStack(spacing: 8) {

                    Label(light, systemImage: "sun.max")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())

                    Label(water, systemImage: "drop")
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
        }
        .listRowBackground(Color.black)
    }
}
    



#Preview {
    TodayReminder(viewModel: PlantsViewModel())
}


