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
    @StateObject var stateManager = StateManager()
    
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
                if stateManager.navigateToLoadingScreen {
                    LoadingScreen()
                }
                
                if stateManager.navigateToWelcomeScreen {
                    WelcomeScreen()
                }
                
                if stateManager.navigateToHomeScreen {
                    HomeScreen()
                }
                
                if stateManager.navigateToDepartmentLoginScreen {
                    DepartmentLoginScreen()
                }
            }
        }
        .modelContainer(container)
        .environmentObject(subscriptionManager)
        .environmentObject(currentOfficer)
        .environmentObject(stateManager)
    }
}

