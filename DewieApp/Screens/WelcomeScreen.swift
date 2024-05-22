//
//  SwiftUIView.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import SwiftUI

struct WelcomeScreen: View {
    @StateObject var currentOfficer = CurrentOfficer()
    @State var shouldNavigate: Bool = false
    
    var body: some View {
        ZStack {
            Color.dewieGreen
                .ignoresSafeArea()
            
            TabView {
                VStack(alignment: .leading) {
                    Image(.dewieLogo)
                        .resizable()
                        .scaledToFit()
                    
                    Text("The all-in-one app that will help you keep accurate records of your DUI investigation. When complete, you can export the report as PDF or save it to your Camera Roll for export.")
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    Text("Simply follow the screens while conductin a DUI investigation following NHSTA procedures, and document your findings.")
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                ZStack {
                    NewOfficerProfileView(currentOfficer: currentOfficer.currentOfficer, shouldNavigate: $shouldNavigate)
                }
                .navigationDestination(isPresented: $shouldNavigate) {
                    HomeScreen().navigationBarBackButtonHidden(true)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
    }
}

#Preview {
    WelcomeScreen()
}
