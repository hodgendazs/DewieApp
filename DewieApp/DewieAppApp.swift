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
    @State var hasDepartmentLicense: Bool = false
    @StateObject private var subscriptionManager = SubscriptionManager()
    
    init() {
        // create database container from SwiftData
        do {
            container = try ModelContainer(for: Officer.self)
        } catch {
            fatalError("Failed to initialize container.")
        }
        


        
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoadingScreen()
            }
        }
        .modelContainer(container)
    }
}
