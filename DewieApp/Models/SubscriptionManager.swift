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
    
    func validateDepartmentCode(departmentCode: String) {
        if departmentCode == "betaTest" {
            UserDefaults.standard.set(true, forKey: "hasValidDepartmentLicense")
            hasActiveDepartmentLicense = true
            hasFullAccess = true
        }
    }
}
