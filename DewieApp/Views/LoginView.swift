//
//  LoginView.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/28/24.
//

import SwiftUI
import Supabase

struct LoginView: View {
    @State var rank: OfficerRanks = .officer
    @State var firstName = ""
    @State var lastName = ""
    @State var badgeNumber = ""
    @State var email = ""
    @State var departmentId = ""
    @State var password = ""
    @State var isLoading = false
    @State var result: Result<Void, Error>?
    
    var body: some View {
        Form {
            Section {
                List {
                    Picker("Rank", selection: $rank) {
                        ForEach(OfficerRanks.allCases) { rank in
                            Text(rank.rawValue.capitalized)}
                    }
                }
                
                TextField("First Name", text: $firstName)
                    .textContentType(.givenName)
                    .autocorrectionDisabled()
                
                TextField("Last Name", text: $lastName)
                    .textContentType(.familyName)
                    .autocorrectionDisabled()
                
                TextField("Badge Number", text: $badgeNumber)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                TextField("Department Id", text: $departmentId)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            
            Section {
                TextField("Password", text: $password)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            
            Section {
                HStack {
                    Spacer()
                    Button ("Sign up") {
                        signUpButtonTapped()
                    }
                    Spacer()
                    
                    if isLoading {
                        ProgressView()
                    }
                }
            }
            
            if let result {
                Section {
                    switch result {
                    case .success:
                        Text("Check your inbox.")
                    case .failure(let error):
                        Text(error.localizedDescription).foregroundStyle(.red)
                    }
                }
            }
        }
        .onOpenURL(perform: { url in
            Task {
                do {
                    try await supabase.auth.session(from: url)
                } catch {
                    self.result = .failure(error)
                }
            }
        })
    }
    
    func signInButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await supabase.auth.signInWithOTP(
                    email: email,
                    redirectTo: URL(string: "io.supabase.user-management://login-callback")
                )
                result = .success(())
            } catch {
                result = .failure(error)
            }
        }
    }
    
    func signUpButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            
            do {
                try await supabase.auth.signUp(email: email, password: password, redirectTo: URL(string: "io.supabase.user-management://login-callback")
                )
                result = .success(())
                let user = try await supabase.auth.session.user
                print(user.id)
                //try await addUserToDatabase(rank: rank.rawValue, firstName: firstName, lastName: lastName, badgeNumber: badgeNumber, email: email, departmentId: departmentId)
            } catch {
                result = .failure(error)
            }
        }
    }
}

#Preview {
    LoginView()
}
