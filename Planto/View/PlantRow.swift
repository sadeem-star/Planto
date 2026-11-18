import SwiftUI

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
                .foregroundStyle(isDone ? Color(red: 0.42, green: 0.87, blue: 0.67) : .gray)
                .onTapGesture {
                    isDone.toggle()
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
                        .foregroundStyle(Color(red: 0.800, green: 0.780, blue: 0.522))   // #CCC785
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.094, green: 0.094, blue: 0.114))     // #18181D
                        .clipShape(Capsule())

                    Label(water, systemImage: "drop")
                        .font(.footnote)
                        .foregroundStyle(Color(red: 0.792, green: 0.953, blue: 0.984))   // #CAF3FB
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.094, green: 0.094, blue: 0.114))     // #18181D
                        .clipShape(Capsule())
                }
            }
            .opacity(isDone ? 0.5 : 1)   // باهت لما تنسقى النبتة
        }
        .listRowBackground(Color.black)
    }
}

#Preview {
    PlantRow(room: "Kitchen", name: "Monstera", light: "Full sun",
             water: "20-50 ml", isDone: .constant(false))
        .padding()
        .background(Color.black)
}
