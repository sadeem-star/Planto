//
//  SwiftUIView.swift
//  Planto
//
//  Created by sadeem on 30/05/1448 AH.
//

import SwiftUI

struct Homepage: View {
    var viewModel: PlantsViewModel
    @State private var showSheet = false
    var body: some View {
    
        NavigationStack{
    
            VStack(spacing: 20) {
                Divider()
                
                
                Spacer()
                Image(.plant1)
                    .padding(.top, 40)
                Text("Start your plant journey!")
                    .font(.system(size: 20, weight: .bold))
                Text("Now all your plants will be in one place and \nwe will help you take care of them :)🪴")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                    
                Button {
                    showSheet = true
                } label: {
                    Text("Set Plant Reminder")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 260, height: 40)
                        .background(Color(red: 0.24, green: 0.48, blue: 0.39))
                        .clipShape(Capsule())
                }
                .padding(.bottom, 100)
                }
               Spacer(minLength: 82)
                
            }
        .navigationTitle("My Plants 🌱")
        .sheet(isPresented: $showSheet) {
            SetReminderView(viewModel: viewModel)
        }
    }
}

