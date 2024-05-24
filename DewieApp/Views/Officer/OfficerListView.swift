//
//  OfficerListView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/19/24.
//

import SwiftUI
import SwiftData

struct OfficerListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Officer.lastAccessed, order: .reverse) private var officers: [Officer]
    @State private var shouldNavigate: Bool = false
    @State private var selectedOfficer: Officer?
    @EnvironmentObject var currentOfficer: OfficerManager

    
    private func deleteOfficer(indexSet: IndexSet) {
        indexSet.forEach { index in
            let officer = officers[index]
            modelContext.delete(officer)
            do {
                try modelContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.dewieGreen
                .ignoresSafeArea()
            VStack {
                if officers.isEmpty {
                    Text("Officer database is empty.")
                } else {
                    ForEach(officers.sorted(by: { $0.lastAccessed > $1.lastAccessed })) { officer in
                        Button {
                            selectedOfficer = officer
                            selectedOfficer?.lastAccessed = Date()
                            do {
                                try modelContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            currentOfficer.currentOfficer = selectedOfficer
                            shouldNavigate = true
                        } label: {
                            Text("\(officer.badgeNumber): \(officer.lastName)")
                                .foregroundStyle(.dewieGreen)
                        }
                        .controlSize(.large)
                        .tint(.black)
                        .buttonStyle(.borderedProminent)
                    }
                    .onDelete(perform: deleteOfficer)
                    .background(.dewieGreen)
                    
                }
            }
        }
        .navigationDestination(isPresented: $shouldNavigate) {
            HomeScreen()
                .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    NavigationStack {
        OfficerListView()
            .modelContainer(multipleOfficerPreviewContainer)
    }
}
