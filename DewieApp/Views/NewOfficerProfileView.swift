//
//  SwiftUIView.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import SwiftUI
import SwiftData

struct NewOfficerProfileView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var currentOfficer: Officer?
    
    // variables that will be added into the new officer
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var badgeNumber: String = ""
    @State var department: String = ""
    @State var departmentEmail: String = ""
    @State var pdfExport: Bool = true
    @State var imageExport: Bool = false
    
    @Binding var shouldNavigate: Bool
    
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
                        
                        // officer information section
                        Section(header: Text("Officer Information (required)").textScale(.secondary)) {
                            TextField("First Name", text: $firstName)
                            TextField("Last Name", text: $lastName)
                            TextField("Badge Number", text: $badgeNumber)
                            TextField("Department", text: $department)
                            TextField("Department Email", text: $departmentEmail)
                        }
                        
                        // export type section
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
                        
                        // save profile button
                        HStack {
                            Spacer()
                            Button {
                                currentOfficer = Officer(id: UUID(), lastAccessed: Date(), firstName: firstName, lastName: lastName, badgeNumber: badgeNumber, department: department, departmentEmail: departmentEmail, pdfExport: pdfExport, imageExport: imageExport, reports: [])
                                
                                if let newOfficer = currentOfficer {
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
                            .disabled(!isFormValid)
                            
                            Spacer()
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            
        }
    }
}

#Preview {
    NewOfficerProfileView(currentOfficer: .previewOfficerData, shouldNavigate: .constant(false))
}
