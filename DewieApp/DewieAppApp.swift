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
    
    init() {
        // create database container from SwiftData
        do {
            container = try ModelContainer(for: Officer.self)
        } catch {
            fatalError("Failed to initialize container.")
        }
        
        // check to see if there is a department license
        hasDepartmentLicense = UserDefaults.standard.bool(forKey: "hasDepartmentLicense")
        
        if !hasDepartmentLicense {
            Purchases.configure(withAPIKey: "appl_qeHhuzIGQvHBeuLSSBCafrkctxV")
        }
        
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasDepartmentLicense {
                    //DepartmentWelcomeScreen()
                } else {
                    //if container.mainContext.model(for: Officer.self)
                    WelcomeScreen()
                }
            }
        }
        .modelContainer(container)
    }
}
