//
//  SubscriptionManager.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/21/24.
//

import SwiftUI
import Foundation
import RevenueCat

class SubscriptionManager: ObservableObject {
    @Published var hasActiveSubscription: Bool = false
    @Published var hasActiveDepartmentLicense: Bool = false
    @Published var hasFullAccess: Bool = false
    @Published var departmentLicenseCode: String = ""
    @Published var departmentLicenseExpirationDate: String = ""
    
    func validateDepartmentCode(departmentCode: String) {
        if departmentCode == "dewiebeta406!" {
            UserDefaults.standard.set(true, forKey: "hasValidDepartmentLicense")
            hasActiveDepartmentLicense = true
            hasFullAccess = true
        }
    }
}
