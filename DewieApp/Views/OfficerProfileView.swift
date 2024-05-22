//
//  OfficerProfileView.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import SwiftUI
import SwiftData
import RevenueCatUI

struct OfficerProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var subscriptionManager = SubscriptionManager()
    @State var currentOfficer: Officer
    
    @State private var shouldLogout: Bool = false
    
    
    @State var displayPaywall: Bool = false
    
    private var isFormValid: Bool {
        !currentOfficer.firstName.isEmptyOrWhiteSpace && !currentOfficer.lastName.isEmptyOrWhiteSpace && !currentOfficer.department.isEmptyOrWhiteSpace && !currentOfficer.departmentEmail.isEmptyOrWhiteSpace && !currentOfficer.badgeNumber.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        ZStack {
            VStack {
                if currentOfficer.lastName.hasSuffix("s") {
                    Text("Officer \(currentOfficer.lastName)' Profile")
                } else {
                    Text("Officer \(currentOfficer.lastName)'s Profile")
                }
                
                Form {
                    Section(header: Text("Officer Information (required)").textScale(.secondary)) {
                        TextField("First Name", text: $currentOfficer.firstName)
                        TextField("Last Name", text: $currentOfficer.lastName)
                        TextField("Badge Number", text: $currentOfficer.badgeNumber)
                        TextField("Department", text: $currentOfficer.department)
                        TextField("Department Email", text: $currentOfficer.departmentEmail)
                    }
                    
                    Section(header: Text("Export Type").textScale(.secondary)) {
                        Toggle("PDF Export", isOn: $currentOfficer.pdfExport)
                            .onChange(of: currentOfficer.pdfExport) {
                                currentOfficer.imageExport = !currentOfficer.pdfExport
                            }
                        Toggle("Image Export", isOn: $currentOfficer.imageExport)
                            .onChange(of: currentOfficer.imageExport) {
                                currentOfficer.pdfExport = !currentOfficer.imageExport
                            }
                    }
                    
                    if !subscriptionManager.hasActiveSubscription {
                        Section(header: Text("Subscribe").textScale(.secondary)) {
                            HStack {
                                Spacer()
                                Button {
                                    displayPaywall = true
                                } label: {
                                    Text("Subscribe")
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $displayPaywall) {
                PaywallView(displayCloseButton: true)
            }
        }
    }
}

#Preview {
    OfficerProfileView(currentOfficer: .previewOfficerData)
}
