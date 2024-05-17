//
//  DewieAppApp.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import SwiftUI
import SwiftData

@main
struct DewieAppApp: App {
    let container: ModelContainer
    
    init() {
        do {
            //let config1 = ModelConfiguration(for: Officer.self)
            //let config2 = ModelConfiguration(for: License.self)
            container = try ModelContainer(for: Officer.self, License.self)
            // if we need to do a data migration, then the line above this will change to:
            // container = try ModelContainer(for: Officer.self, migrationPlan: OfficerMigrationPlan.self)
        } catch {
            fatalError("Failed to initialize container.")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeScreen()
            }
        }
        .modelContainer(container)
    }
}
