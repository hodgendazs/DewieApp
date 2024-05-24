//
//  LoadingScreen.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/21/24.
//

import SwiftUI
import SwiftData

struct LoadingScreen: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @EnvironmentObject var currentOfficer: OfficerManager
    @Query var officers: [Officer]
    
    var body: some View {
        Text("Loading...")
            .onAppear {
                if !officers.isEmpty {
                    print("Database is not empty.")
                    if officers.count > 1 {
                        print("Multiple officers in database. Setting department variable.")
                        UserDefaults.standard.set(true, forKey: "multipleOfficersInDatabase")
                    } else if !UserDefaults.standard.bool(forKey: "hasValidDepartmentCode") {
                        currentOfficer.currentOfficer = officers[0]
                        currentOfficer.isSingleOfficerLoadedFromDatabase = true
                    }
                } else {
                    print("Officer database is empty.")
                }
                
                if UserDefaults.standard.bool(forKey: "hasValidDepartmentCode") {
                    subscriptionManager.hasActiveDepartmentLicense = true
                }
                
                if currentOfficer.currentOfficer?.departmentCode == "betaTest" {
                    subscriptionManager.hasActiveDepartmentLicense = true
                }
                currentOfficer.isLoading = false
            }
    }
}

#Preview {
    LoadingScreen()
}
