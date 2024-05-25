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
    @EnvironmentObject var subscriptionManager: SubscriptionManager
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
                        HStack {
                            TextField("Department Code", text: $currentOfficer.departmentCode)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                            Button {
                                print(subscriptionManager.hasActiveDepartmentLicense)
                                if subscriptionManager.hasActiveDepartmentLicense == true {
                                    currentOfficer.departmentCode = ""
                                    subscriptionManager.hasActiveDepartmentLicense = false
                                }
                                
                                if subscriptionManager.hasActiveDepartmentLicense == false {
                                    if subscriptionManager.validateDepartmentCode(departmentCode: currentOfficer.departmentCode) == true {
                                        subscriptionManager.hasActiveDepartmentLicense = true
                                        UserDefaults.standard.set(true, forKey: "hasValidDepartmentCode")
                                    }
                                }
                            } label: {
                                Text(subscriptionManager.hasActiveDepartmentLicense ? "Clear" : "Submit")
                            }
                        }
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
                    if showSubscribe && subscriptionManager.hasActiveDepartmentLicense == false {
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
                        if subscriptionManager.hasActiveDepartmentLicense == true {
                            Section(header: Text("").textScale(.secondary)) {
                                HStack {
                                    Spacer()
                                    
                                    Button {
                                        shouldLogout = true
                                    } label: {
                                        Text("Logout")
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $displayPaywall) {
                PaywallView(displayCloseButton: true)
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
