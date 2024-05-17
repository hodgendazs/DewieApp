//
//  ProfileView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/19/24.
//

import SwiftUI
import SwiftData

struct OfficerProfileView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var currentOfficer: Officer
    @State private var shouldLogout: Bool = false
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var badgeNumber: String = ""
    @State var department: String = ""
    @State var departmentEmail: String = ""
    //@State var lackOfConvergence: Bool = false
    //@State var modifiedRomberg: Bool = false
    //@State var fingerToNose: Bool = false
    
    private var isFormValid: Bool {
        !firstName.isEmptyOrWhiteSpace && !lastName.isEmptyOrWhiteSpace && !department.isEmptyOrWhiteSpace && !departmentEmail.isEmptyOrWhiteSpace && !badgeNumber.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        ZStack {
            VStack {
                if currentOfficer.lastName.hasSuffix("s") {
                    Text("Officer \(lastName)' Profile")
                        .font(.title)
                        .padding(.horizontal)
                        .padding(.top, 25)
                } else {
                    Text("Officer \(lastName)'s Profile")
                        .font(.title)
                        .padding(.horizontal)
                        .padding(.top, 25)
                }
                
                Form {
                    Section(header: Text("Officer Information (Required)").textScale(.secondary).foregroundStyle(.black)) {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Badge Number", text: $badgeNumber)
                        TextField("Department", text: $department)
                        TextField("Department Email", text: $departmentEmail)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    
//                    Section(header: Text("Additional Tests (Optional)").textScale(.secondary).foregroundStyle(.black)) {
//                        Toggle("Lack of Convergence", isOn: $currentOfficer.lackOfConvergence)
//                        Toggle("Modified Romberg", isOn: $currentOfficer.modifiedRomberg)
//                        Toggle("Finger to Nose", isOn: $currentOfficer.fingerToNose)
//                    }
                    
                    Section(header: Text("Export Type").textScale(.secondary).foregroundStyle(.black)) {
                        Toggle("PDF", isOn: $currentOfficer.pdfExport)
                            .onChange(of: currentOfficer.pdfExport) {
                                currentOfficer.imageExport = !currentOfficer.pdfExport
                            }
                            .foregroundStyle(.gray)
                        Toggle("Image", isOn: $currentOfficer.imageExport)
                            .onChange(of: currentOfficer.imageExport) {
                                currentOfficer.pdfExport = !currentOfficer.imageExport
                            }
                            .foregroundStyle(.gray)
                    }
                }
                .frame(height: 500)
                .padding(.top)
                .scrollContentBackground(.hidden)
                
                NavigationLink {
                    LoginScreen()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Logout")
                        .foregroundStyle(.black)
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
            }
        }
        .onAppear {
            firstName = currentOfficer.firstName
            lastName = currentOfficer.lastName
            badgeNumber = currentOfficer.badgeNumber
            department = currentOfficer.department
            departmentEmail = currentOfficer.departmentEmail
        }
        .onDisappear {
            if isFormValid {
                currentOfficer.firstName = firstName
                currentOfficer.lastName = lastName
                currentOfficer.badgeNumber = badgeNumber
                currentOfficer.department = department
                currentOfficer.departmentEmail = departmentEmail
            }
        }
    }
}

//#Preview {
//    OfficerProfileView(currentOfficer: .constant(Officer(lastAccessed: Date(), firstName: "Thomas", lastName: "Hodge", badgeNumber: "1234", department: "Test Department", departmentEmail: "test@email.com", lackOfConvergence: false, modifiedRomberg: false, fingerToNose: false)))
//}
