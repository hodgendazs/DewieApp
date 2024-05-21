//
//  LoadingScreen.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/20/24.
//

import SwiftUI
import RevenueCat
import SwiftData

struct LoadingScreen: View {
    @Environment(\.modelContext) var modelContext
    @State var currentOfficer: Officer?
    @State var badgeNumber: String = ""
    @Query(filter: #Predicate<Officer> { officer in
        officer.badgeNumber == badgeNumber
    }) var officer: Officer?
    
    init() {
        if UserDefaults.standard.string(forKey: "localOfficerId") != "" {
            let officerId = UserDefaults.standard.string(forKey: "localOfficerBadgeNumber")
        }
    }
    
    var body: some View {
        Text("Loading...")
            .onAppear {
                if UserDefaults.standard.bool(forKey: "localOfficer") == true {
                    let officerId = UserDefaults.standard.string(forKey: "localOfficerId")
                    currentOfficer = @Query(filter: #Predicate<Officer> { officer in
                        officer.id == officerId }
                    )
                }
            }
    }
}

#Preview {
    LoadingScreen()
}

struct SelectOfficer {
    @Query private var officer: [Officer]
    
    init(officer: [Officer]) {
        self.officer = officer
    }
    
}
