//
//  DewieApp.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/11/24.
//

import SwiftUI
import SwiftData

@main
struct DewieApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(
                for: Officer.self,
                migrationPlan: OfficerMigrationPlan.self
            )
        } catch {
            fatalError("Failed to initialize container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginScreen()
            }
            .tint(.black)
        }
        .modelContainer(container)
    }
}
