//
//  SubscriptionManager.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/20/24.
//

import Foundation
import RevenueCat
import Combine

class SubscriptionManager: ObservableObject {
    
    @Published var isSubscribed: Bool = false
    
    func checkSubscriptionStatus() {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            if let customerInfo = customerInfo, !customerInfo.entitlements.active.isEmpty {
                           self.isSubscribed = true
                       } else {
                           self.isSubscribed = false
                       }
        }
    }
}
