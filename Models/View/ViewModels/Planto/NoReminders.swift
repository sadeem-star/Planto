import SwiftUI

struct NoReminders: View {
    var viewModel: PlantsViewModel
    @State private var showSheet = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 12)

                Divider()
                    .background(Color.gray)

                Spacer()

                Text("No reminders set yet..")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)

                Spacer()
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                showSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color(red: 0.24, green: 0.55, blue: 0.43))
                    .clipShape(Circle())
            }
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }
        .sheet(isPresented: $showSheet) {
            SetReminderView(viewModel: viewModel)
        }
    }
}

#Preview {
    NoReminders(viewModel: PlantsViewModel())
}
