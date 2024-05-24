//
//  HomeScreen.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    @EnvironmentObject var currentOfficer: OfficerManager
    @State var shouldLogout: Bool = false
    
    var body: some View {
        TabView {
            // PriorReportView when it gets created
            ReportsView()
                .tabItem { Label("Reports", systemImage: "note.text") }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.black, for: .tabBar)
            // NewReportView when it gets created
            
            // OfficerProfileView when it gets created
            if let currentOfficer = currentOfficer.currentOfficer {
                OfficerProfileView(currentOfficer: currentOfficer)
                    .tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.black, for: .tabBar)
            }
        }
        .tint(.dewieGreen)
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        
        return HomeScreen()
            .modelContainer(container)
    }
}
