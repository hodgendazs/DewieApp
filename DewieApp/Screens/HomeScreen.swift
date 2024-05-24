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
    @StateObject var subscriptionManager = SubscriptionManager()
    @State var shouldLogout: Bool = false
    @State var showNewReportView: Bool = false
    
    var body: some View {
        TabView {
            // PriorReportView when it gets created
            if let currentOfficer = currentOfficer.currentOfficer {
                ReportsView(currentOfficer: currentOfficer)
                    .tabItem { Label("Reports", systemImage: "note.text") }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(Color.black, for: .tabBar)
            }
            // NewReportView when it gets created
            if showNewReportView {
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
        .onChangeOf(currentOfficer.currentOfficer?.departmentCode) { newValue in
            if subscriptionManager.validateDepartmentCode(departmentCode: newValue ?? "") {
                showNewReportView = true
            } else {
                showNewReportView = false
            }      
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: "hasValidDepartmentCode") {
                showNewReportView = true
            }
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
