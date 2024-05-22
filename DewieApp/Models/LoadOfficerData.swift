//
//  LoadData.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/21/24.
//

import Foundation
import SwiftData
import SwiftUI

class LoadOfficerData {
    //@Environment(\.modelContext) private var modelContext
    @StateObject var currentOfficer = CurrentOfficer()
    
    @Query var officers: [Officer]
    
    func loadData() -> Officer {
        
        return officers.first ?? Officer(lastAccessed: Date(), firstName: "", lastName: "", badgeNumber: "", department: "", departmentEmail: "", pdfExport: true, imageExport: false, reports: [])
        
        
    }
    
}
