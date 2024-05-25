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
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @State var shouldLogout: Bool = false
    
    var body: some View {
        TabView {

            if let currentOfficer = currentOfficer.currentOfficer {
                ReportsView(currentOfficer: currentOfficer)
                    .tabItem { Label("Reports", systemImage: "note.text") }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.black, for: .tabBar)
            }
            
            if subscriptionManager.hasFullAccess {
                if let currentOfficer = currentOfficer.currentOfficer {
                    NewReportView(currentOfficer: currentOfficer)
                        .tabItem {
                            Label("New Report", systemImage: "note.text.badge.plus")
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                        .toolbarBackground(Color.black, for: .tabBar)
                }
            }
            
            // OfficerProfileView when it gets created
            if let currentOfficer = currentOfficer.currentOfficer {
                OfficerProfileView(currentOfficer: currentOfficer, shouldLogout: $shouldLogout)
                    .tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.black, for: .tabBar)
            }
        }
        .tint(.dewieGreen)
        .navigationDestination(isPresented: $shouldLogout) {
            OfficerListView()
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        
        return HomeScreen()
            .modelContainer(container)
    }
}
