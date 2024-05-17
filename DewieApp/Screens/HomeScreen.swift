//
//  HomeScreen.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var currentOfficer: Officer
    @State var shouldLogout: Bool = false
    
    var body: some View {
        TabView {
            // PriorReportView when it gets created
            
            // NewReportView when it gets created
            
            // OfficerProfileView when it gets created
            OfficerProfileView(currentOfficer: $currentOfficer)
                .tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.black, for: .tabBar)
        }
        .tint(.dewieGreen)
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        
        return HomeScreen(currentOfficer: .previewOfficerData)
            .modelContainer(container)
    }
}
