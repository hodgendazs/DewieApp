//
//  ContentView.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/24/24.
//

import SwiftUI
import SwiftData
import RevenueCat

struct LoadingScreen: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @EnvironmentObject var officerManager: OfficerManager
    @EnvironmentObject var stateManager: StateManager
    @Query var officers: [Officer]
    
    var body: some View {
        ZStack {
            Color.dewieGreen
                .ignoresSafeArea()
        }
        .onAppear {
            
            if UserDefaults.standard.bool(forKey: "hasValidDepartmentLicense") == true {
                subscriptionManager.hasActiveDepartmentLicense = true
                subscriptionManager.hasFullAccess = true
                stateManager.navigateToLoadingScreen = false
                stateManager.navigateToDepartmentLoginScreen = true
            }

            
            if !UserDefaults.standard.bool(forKey: "hasValidDepartmentLicense") || !subscriptionManager.hasActiveDepartmentLicense {
                print("loading officer")
                loadOfficer()
            }
        }
    }
    
    func loadOfficer() {
        if officers.count == 1 {
            print("LoadingScreen/LoadOfficer: \(officers.count)")
            officerManager.currentOfficer = officers[0]
            checkSubscription()
            stateManager.navigateToLoadingScreen = false
            stateManager.navigateToHomeScreen = true
        }
        
        if officers.isEmpty {
            checkSubscription()
            stateManager.navigateToLoadingScreen = false
            stateManager.navigateToWelcomeScreen = true
        }
    }
    
    func checkSubscription() {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            if customerInfo?.entitlements.all["dewie-fullaccess"]?.isActive == true {
                subscriptionManager.hasActiveSubscription = true
                subscriptionManager.hasFullAccess = true
            } else {
                subscriptionManager.hasActiveSubscription = false
                subscriptionManager.hasFullAccess = false
            }
        }
    }
    
}

#Preview {
    LoadingScreen()
}
