import SwiftUI

struct RootView: View {
    @State private var viewModel = PlantsViewModel()
    var body: some View {
        if !viewModel.plants.isEmpty {
            TodayReminder(viewModel: viewModel)
        } else if viewModel.hasAddedBefore {
            NoReminders(viewModel: viewModel)
        } else {
            Homepage(viewModel: viewModel)
        }
    }
}

#Preview {
    RootView()
}
