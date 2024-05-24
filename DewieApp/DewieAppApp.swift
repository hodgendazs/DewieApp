//
//  DewieAppApp.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import SwiftUI
import SwiftData
import RevenueCat

@main
struct DewieAppApp: App {
    let container: ModelContainer
    @StateObject var subscriptionManager = SubscriptionManager()
    @StateObject var currentOfficer = OfficerManager()
    
    init() {
        do {
            container = try ModelContainer(for: Officer.self)
        } catch {
            fatalError("Failed to initialize container.")
        }
        
        Purchases.configure(withAPIKey: "appl_qeHhuzIGQvHBeuLSSBCafrkctxV")
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if currentOfficer.isLoading {
                    LoadingScreen()
                } else {
                    decideInitialView()
                }
            }
        }
        .modelContainer(container)
        .environmentObject(subscriptionManager)
        .environmentObject(currentOfficer)
    }
    
    @ViewBuilder
    private func decideInitialView() -> some View {
        if UserDefaults.standard.bool(forKey: "hasValidDepartmentCode") {
            let _ = print("going to department login screen")
            DepartmentLoginScreen()
        } else if currentOfficer.isSingleOfficerLoadedFromDatabase {
            let _ = print("going to home screen")
            HomeScreen()
                .environmentObject(currentOfficer)
        } else {
            let _ = print("going to welcome screen")
            WelcomeScreen()
        }
    }
}

