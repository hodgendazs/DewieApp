//
//  Supabase.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/28/24.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://wblrbkchlyqhluwroytq.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndibHJia2NobHlxaGx1d3JveXRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY5NDE4NzIsImV4cCI6MjAzMjUxNzg3Mn0.nSRMjjRX2qDI3-BzhT4hOGmC_K8HbQSWf9RwM2xtHHc"
)

func addUserToDatabase(rank: String, firstName: String, lastName: String, badgeNumber: String, email: String, departmentId: String) async throws {
    
    let newOfficer = NewOfficer(rank: rank, first_name: firstName, last_name: lastName, badge_number: badgeNumber, email: email, department_id: departmentId)
    
    try await supabase
        .from("Officers")
        .insert(newOfficer)
        .execute()
}

struct NewOfficer: Encodable {
    let rank: String
    let first_name: String
    let last_name: String
    let badge_number: String
    let email: String
    let department_id: String
}
