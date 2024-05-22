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
    @StateObject var currentOfficer = CurrentOfficer()
    
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
                if !subscriptionManager.hasActiveDepartmentLicense && !subscriptionManager.hasActiveSubscription {
                    WelcomeScreen()
                } else if subscriptionManager.hasActiveSubscription {
                    HomeScreen()
                } else {
                    WelcomeScreen()
                }
            }
        }
        .modelContainer(container)
        .environmentObject(subscriptionManager)
        .environmentObject(currentOfficer)
    }
    
//    func loadData() -> Officer {
//        self.container.mainContext.fetch(<#T##descriptor: FetchDescriptor<PersistentModel>##FetchDescriptor<PersistentModel>#>)
//        return officers.first ?? Officer(lastAccessed: Date(), firstName: "", lastName: "", badgeNumber: "", department: "", departmentEmail: "", pdfExport: true, imageExport: false, reports: [])
//        
//        
//    }
    
}


