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
    @EnvironmentObject var currentOfficer: OfficerManager
    @Published var hasActiveSubscription: Bool?
    @Published var hasActiveDepartmentLicense: Bool = false
    
    init() {
        // check if active department license
        if UserDefaults.standard.bool(forKey: "hasActiveDepartmentLicense") == true {
            self.hasActiveDepartmentLicense = true
        } else {
            // check if active subscription
            Purchases.shared.getCustomerInfo { (customerInfo, error) in
                if customerInfo?.entitlements.all["dewie-fullaccess"]?.isActive == true {
                    self.hasActiveSubscription = true
                    print("has active sub")
                } else {
                    self.hasActiveSubscription = false
                }
            }
        }

        
    }
}
