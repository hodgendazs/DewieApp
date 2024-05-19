//
//  SubscribeView.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/18/24.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

struct SubscribeView: View {
    var body: some View {
        VStack {

        }
        .presentPaywallIfNeeded(requiredEntitlementIdentifier: "dewie-fullaccess")
    }
}

#Preview {
    SubscribeView()
}
