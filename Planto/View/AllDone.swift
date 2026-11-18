import SwiftUI

struct AllDone: View {
    var viewModel: PlantsViewModel
    @State private var showSheet = false
    var body: some View {
        ZStack {
            // الخلفية السوداء
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                // العنوان
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                
                
                Divider()
                    .background(Color.gray)
                Spacer()
                
                
                VStack(spacing: 12) {
                    
                    Image("plant2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 164, height: 200)
                    
                    Text("All Done! 🎉")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 16)
                    
                    Text("All Reminders Completed")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity)   .padding(.bottom, 80)
                Spacer()
                
                
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
}

#Preview {
    AllDone(viewModel: PlantsViewModel())
}
