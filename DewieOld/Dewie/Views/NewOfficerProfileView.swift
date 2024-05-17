//
//  OfficerView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/22/24.
//

import SwiftUI
import SwiftData

struct NewOfficerProfileView: View {
    @Environment(\.modelContext) var modelContext
    @State var officer: Officer?
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var badgeNumber: String = ""
    @State var department: String = ""
    @State var departmentEmail: String = ""
    @State var lackOfConvergence: Bool = false
    @State var modifiedRomberg: Bool = false
    @State var fingerToNose: Bool = false
    @State var pdfExport: Bool = true
    @State var imageExport: Bool = false
    @State private var shouldNavigate: Bool = false
    
    
    private var isFormValid: Bool {
        !firstName.isEmptyOrWhiteSpace && !lastName.isEmptyOrWhiteSpace && !department.isEmptyOrWhiteSpace && !departmentEmail.isEmptyOrWhiteSpace && !badgeNumber.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        ZStack {
            Color.dewieGreen
                .ignoresSafeArea()
            VStack {
                VStack {
                    Form {
                        Section(header: Text("Officer Information (Required)").textScale(.secondary).foregroundStyle(.black)) {
                            TextField("First Name", text: $firstName)
                            
                            TextField("Last Name", text: $lastName)
                            
                            TextField("Badge Number", text: $badgeNumber)
                                .keyboardType(.numberPad)
                            
                            TextField("Department", text: $department)
                            
                            TextField("Department Email", text: $departmentEmail)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        }
                        
//                        Section(header: Text("Additional Tests (Optional)").textScale(.secondary).foregroundStyle(.black)) {
//                            Toggle("Lack of Convergence", isOn: $lackOfConvergence)
//                            Toggle("Modified Romberg", isOn: $modifiedRomberg)
//                            Toggle("Finger to Nose", isOn: $fingerToNose)
//                        }
                        Section(header: Text("Export Type").textScale(.secondary).foregroundStyle(.black)) {
                            Toggle("PDF", isOn: $pdfExport)
                                .onChange(of: pdfExport) {
                                    imageExport = !pdfExport
                                }
                                .foregroundStyle(.gray)
                            Toggle("Image", isOn: $imageExport)
                                .onChange(of: imageExport) {
                                    pdfExport = !imageExport
                                }
                                .foregroundStyle(.gray)
                        }
                        
                        HStack {
                            Spacer()
                            Button {
                                officer = Officer(id: UUID(), lastAccessed: Date(), firstName: firstName, lastName: lastName, badgeNumber: badgeNumber, department: department, departmentEmail: departmentEmail, lackOfConvergence: lackOfConvergence, modifiedRomberg: modifiedRomberg, fingerToNose: fingerToNose, pdfExport: pdfExport, imageExport: imageExport, reports: [])
                                
                                if let newOfficer = officer {
                                    print("Saving officer data")
                                    
                                    modelContext.insert(newOfficer)
                                }
                                
                                do {
                                    try modelContext.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                shouldNavigate = true
                            } label: {
                                Text("Save Profile")
                            }
                            .padding(.horizontal, 20)
                            .disabled(!isFormValid)

                            Spacer()
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationDestination(isPresented: $shouldNavigate) {
                if let officer = officer {
                    HomeScreen(currentOfficer: officer).navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    NewOfficerProfileView()
}
