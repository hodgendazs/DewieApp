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
    @EnvironmentObject var currentOfficer: OfficerManager
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @State var newOfficer: Officer?
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var badgeNumber: String = ""
    @State var department: String = ""
    @State var departmentEmail: String = ""
    @State var departmentCode: String = ""
    @State var pdfExport: Bool = true
    @State var imageExport: Bool = false
    
    @State var departmentLogo: UIImage?
    @State var presentImagePicker: Bool = false
    
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
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                        }
                        
                        // department code entry
                        Section(header: Text("Department Code (optional)").textScale(.secondary)) {
                            TextField("Department Code", text: $departmentCode)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
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
                        
                        Section(header: Text("Department Logo").textScale(.secondary)) {
                            VStack {
                                HStack {
                                    Spacer()
                                    Button {
                                        presentImagePicker = true
                                        if let departmentLogoImage = departmentLogo {
                                            saveImageToUserDefaults(image: departmentLogoImage)
                                        }
                                    } label: {
                                        if (departmentLogo != nil) {
                                            Image(uiImage: departmentLogo!)
                                                .resizable()
                                                .scaledToFit()
                                        } else {
                                            Text("Select Department Logo")
                                        }
                                    }
                                    Spacer()
                                }
                                
                                HStack {
                                    if departmentLogo != nil {
                                        Spacer()
                                        Button {
                                            deleteImageFromUserDefaults()
                                        } label: {
                                            Text("Remove Department Logo")
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        }
                        
                        // save profile button
                        HStack {
                            Spacer()
                            Button {
                                newOfficer = Officer(id: UUID(), lastAccessed: Date(), firstName: firstName, lastName: lastName, badgeNumber: badgeNumber, department: department, departmentEmail: departmentEmail, departmentCode: "", pdfExport: pdfExport, imageExport: imageExport, reports: [])
                                
                                if let newOfficer = newOfficer {
                                    modelContext.insert(newOfficer)
                                }
                                
                                do {
                                    try modelContext.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                currentOfficer.currentOfficer = newOfficer
                                
                                subscriptionManager.validateDepartmentCode(departmentCode: departmentCode)
                                
                                if let departmentLogoImage = departmentLogo {
                                    saveImageToUserDefaults(image: departmentLogoImage)
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
                    .sheet(isPresented: $presentImagePicker) {
                        ImagePicker(image: $departmentLogo)
                    }
                    .onAppear {
                        loadImageFromUserDefaults()
                    }
                }
            }
        }
    }
    func saveImageToUserDefaults(image: UIImage) {
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                UserDefaults.standard.setValue(imageData, forKey: "departmentLogo")
            }
        }
    
    func loadImageFromUserDefaults() {
        if let imageData = UserDefaults.standard.data(forKey: "departmentLogo"),
           let savedImage = UIImage(data: imageData) {
            self.departmentLogo = savedImage
        }
    }
    
    func deleteImageFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "departmentLogo")
        self.departmentLogo = nil
    }
}

#Preview {
    NewOfficerProfileView(newOfficer: .previewOfficerData, shouldNavigate: .constant(false))
}
