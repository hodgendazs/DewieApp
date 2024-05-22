//
//  LoadOfficer.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/21/24.
//

import Foundation
import SwiftData
import SwiftUI

class CurrentOfficer: ObservableObject {
    @Published var currentOfficer: Officer = Officer(lastAccessed: Date(), firstName: "", lastName: "", badgeNumber: "", department: "", departmentEmail: "", pdfExport: true, imageExport: false, reports: [])
    
    init() {
        self.currentOfficer = currentOfficer
    }
    
    func loadOfficer(officerToLoad: Officer) {
        currentOfficer = officerToLoad
    }
    
}
