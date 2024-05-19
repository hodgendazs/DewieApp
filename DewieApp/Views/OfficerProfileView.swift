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
    @Environment(\.modelContext) var modelContext
    @Binding var currentOfficer: Officer
    @State private var shouldLogout: Bool = false
    
    // profile variables
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var badgeNumber: String = ""
    @State var department: String = ""
    @State var departmentEmail: String = ""
    @State var pdfExport: Bool = false
    @State var imageExport: Bool = false
    
    @State var showPaywall: Bool = false
    @State var hasLicense: Bool = false
    
    private var isFormValid: Bool {
        !firstName.isEmptyOrWhiteSpace && !lastName.isEmptyOrWhiteSpace && !department.isEmptyOrWhiteSpace && !departmentEmail.isEmptyOrWhiteSpace && !badgeNumber.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        ZStack {
            VStack {
                if currentOfficer.lastName.hasSuffix("s") {
                    Text("Officer \(lastName)' Profile")
                } else {
                    Text("Officer \(lastName)'s Profile")
                }
                
                Form {
                    Section(header: Text("Officer Information (required)").textScale(.secondary)) {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Badge Number", text: $badgeNumber)
                        TextField("Department", text: $department)
                        TextField("Department Email", text: $departmentEmail)
                    }
                    
                    Section(header: Text("Export Type").textScale(.secondary)) {
                        Toggle("PDF Export", isOn: $pdfExport)
                            .onChange(of: pdfExport) {
                                imageExport = !pdfExport
                            }
                        Toggle("Image Export", isOn: $imageExport)
                            .onChange(of: imageExport) {
                                pdfExport = !imageExport
                            }
                    }
                    HStack {
                        Spacer()
                        if !hasLicense {
                            Button {
                                showPaywall = true
                            } label: {
                                Text("Subscribe")
                            }
                        }
                        Spacer()
                    }
                }
            }
            .onAppear {
                firstName = currentOfficer.firstName
                lastName = currentOfficer.lastName
                badgeNumber = currentOfficer.badgeNumber
                department = currentOfficer.department
                departmentEmail = currentOfficer.departmentEmail
                pdfExport = currentOfficer.pdfExport
                imageExport = currentOfficer.imageExport
            }
            
            .onDisappear {
                if isFormValid {
                    currentOfficer.firstName = firstName
                    currentOfficer.lastName = lastName
                    currentOfficer.badgeNumber = badgeNumber
                    currentOfficer.department = department
                    currentOfficer.departmentEmail = departmentEmail
                    currentOfficer.pdfExport = pdfExport
                    currentOfficer.imageExport = imageExport
                }
            }
            .sheet(isPresented: $showPaywall, content: {
                PaywallView()
            })
        }
    }
}

#Preview {
    OfficerProfileView(currentOfficer: .constant(.previewOfficerData))
}
