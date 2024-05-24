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
    @Binding var shouldLogout: Bool
    
    @State var showSubscribe: Bool = true
    
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
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                    
                    Section(header: Text("Department Code (optional)").textScale(.secondary)) {
                        TextField("Department Code", text: $currentOfficer.departmentCode)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
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
                    if showSubscribe && UserDefaults.standard.bool(forKey: "hasValidDepartmentCode") == false {
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
                    } else if UserDefaults.standard.bool(forKey: "hasValidDepartmentCode") == true {
                        Section(header: Text("").textScale(.secondary)) {
                            HStack {
                                Spacer()
                                
                                Button {
                                    shouldLogout.toggle()
                                } label: {
                                    Text("Logout")
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
            .onChangeOf(currentOfficer.departmentCode) { newValue in
                if subscriptionManager.validateDepartmentCode(departmentCode: newValue) {
                    UserDefaults.standard.set(true, forKey: "hasValidDepartmentCode")
                    subscriptionManager.hasActiveDepartmentLicense = true
                }
            }
            .onChangeOf(subscriptionManager.hasActiveSubscription) { newValue in
                if newValue == true {
                    showSubscribe = false
                }
            }
        }
    }
}

#Preview {
    OfficerProfileView(currentOfficer: .previewOfficerData, shouldLogout: .constant(false))
}
