//
//  HomeView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/16/24.
//

import SwiftUI

struct HomeScreen: View {
    @Environment (\.colorScheme) var colorScheme
    @State var currentOfficer: Officer
    @State var shouldLogout: Bool = false
        
    var body: some View {
        TabView {
            ReportsView(currentOfficer: $currentOfficer)
                .tabItem {
                    Label("Reports", systemImage: "note.text")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.black, for: .tabBar)
            
            NewReportView(currentOfficer: currentOfficer)
                .tabItem {
                    Label("New Report", systemImage: "note.text.badge.plus")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.black, for: .tabBar)
            
            OfficerProfileView(currentOfficer: $currentOfficer)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.black, for: .tabBar)
        }
        .tint(.dewieGreen)
    }
}



#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        
        return HomeScreen(currentOfficer: .previewOfficer)
            .modelContainer(container)
    }
}
