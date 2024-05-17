//
//  NewOfficerOnboarding.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/22/24.
//

import SwiftUI

struct OfficerOnboardingScreen: View {
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
                    
                    Text("The all-in-one app that will help you keep accurate records of your DUI investigation, and send a report to your email.")
                        .padding(.horizontal, 25)
                        .padding(.bottom, 10)
                    
                    Text("Simply follow the screens while conducting a DUI investigation following NHTSA procedures, and document your findings. Then, export the DEWIE report and automatically send it to your email to attach to your report.")
                        .padding(.horizontal, 25)
                }
                .padding(.horizontal)
                
                ZStack {
                    NewOfficerProfileView()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
    }
}

#Preview {
    OfficerOnboardingScreen()
}
