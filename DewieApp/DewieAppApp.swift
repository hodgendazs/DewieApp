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
                //                if subscriptionManager.hasActiveSubscription == nil {
                //                    LoadingScreen()
                //                }
                if currentOfficer.isLoading {
                    LoadingScreen()
                }
                
                if currentOfficer.isSingleOfficerLoadedFromDatabase == true {
                    HomeScreen()
                        .environmentObject(currentOfficer)
                } else {
                    WelcomeScreen()
                }
                
                
            }
        }
        .modelContainer(container)
        .environmentObject(subscriptionManager)
        .environmentObject(currentOfficer)
    }
}

