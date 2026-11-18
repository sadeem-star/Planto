import SwiftUI

struct RootView: View {
    @State private var viewModel = PlantsViewModel()
    var body: some View {
        Group {
            if !viewModel.plants.isEmpty {
                TodayReminder(viewModel: viewModel)
            } else if viewModel.hasAddedBefore {
                NoReminders(viewModel: viewModel)
            } else {
                Homepage(viewModel: viewModel)
            }
        }
        .onAppear {
            NotificationManager.shared.requestPermission()   // يطلب إذن الإشعارات أول مرة
        }
    }
}

#Preview {
    RootView()
}
