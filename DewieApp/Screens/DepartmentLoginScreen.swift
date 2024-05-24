//
//  DepartmentLoginScreen.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/23/24.
//

import SwiftUI

struct DepartmentLoginScreen: View {
    var body: some View {
        ZStack {
            Color.dewieGreen
                .ignoresSafeArea()
            VStack {
                Image(.dewieLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    .cornerRadius(25)
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                
                VStack {
                    NavigationLink(destination: WelcomeScreen()) {
                        Text("New Officer")
                            .frame(maxWidth: 200)
                            .foregroundStyle(.dewieGreen)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.black)
                    .controlSize(.large)
                    
                    NavigationLink(destination: DepartmentReturningOfficerScreen()) {
                        Text("Returning Officer")
                            .frame(maxWidth: 200)
                            .foregroundStyle(.black)
                    }
                    .tint(Color.white.opacity(0.5))
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DepartmentLoginScreen()
    }
}
