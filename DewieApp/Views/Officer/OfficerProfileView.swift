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
    
    @State var departmentLogo: UIImage?
    @State var presentImagePicker: Bool = false
    
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
                                
                                if subscriptionManager.hasActiveDepartmentLicense == true {
                                    currentOfficer.departmentCode = ""
                                    UserDefaults.standard.set(false, forKey: "hasValidDepartmentLicense")
                                    subscriptionManager.hasActiveDepartmentLicense = false
                                    subscriptionManager.hasFullAccess = false
                                }
                                
                                if subscriptionManager.hasActiveDepartmentLicense == false {
                                    subscriptionManager.validateDepartmentCode(departmentCode: currentOfficer.departmentCode)
                                }
                            } label: {
                                Text(subscriptionManager.hasActiveDepartmentLicense ? "Clear" : "Submit")
                            }
                        }
                    }
                    
//                    Section(header: Text("Export Type").textScale(.secondary)) {
//                        Toggle("PDF Export", isOn: $currentOfficer.pdfExport)
//                            .onChange(of: currentOfficer.pdfExport) {
//                                currentOfficer.imageExport = !currentOfficer.pdfExport
//                            }
//                        Toggle("Image Export", isOn: $currentOfficer.imageExport)
//                            .onChange(of: currentOfficer.imageExport) {
//                                currentOfficer.pdfExport = !currentOfficer.imageExport
//                            }
//                    }
                    
                    Section(header: Text("Department Logo").textScale(.secondary)) {
                        VStack {
                            Spacer()
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
                            Spacer()
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
                            Spacer()
                        }
                    }
                    
                    if !subscriptionManager.hasActiveSubscription && !subscriptionManager.hasActiveDepartmentLicense {
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
                    .onPurchaseCompleted { customerInfo in
                        if customerInfo.entitlements["dewie-fullaccess"]?.isActive == true {
                            subscriptionManager.hasActiveSubscription = true
                            subscriptionManager.hasFullAccess = true
                        }
                    }
            }
            .onChangeOf(subscriptionManager.hasActiveSubscription) { newValue in
                if newValue == true {
                    showSubscribe = false
                }
            }
            .onChangeOf(departmentLogo) {newValue in
                if let departmentLogoImage = departmentLogo {
                    saveImageToUserDefaults(image: departmentLogoImage)
                    print("image saved")
                }
            }
            .onAppear {
                loadImageFromUserDefaults()
            }
            .sheet(isPresented: $presentImagePicker) {
                ImagePicker(image: $departmentLogo)
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
    OfficerProfileView(currentOfficer: .previewOfficerData, shouldLogout: .constant(false))
}
