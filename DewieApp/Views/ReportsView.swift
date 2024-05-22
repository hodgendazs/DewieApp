//
//  ReportsView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/19/24.
//

import SwiftUI

struct ReportsView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var currentOfficer = CurrentOfficer()
    @State var currentOfficerReports: [Report]?
    
    @State private var selectedReport: Report?
    @State private var showReport: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if let currentOfficerReports = currentOfficerReports {
                    if !(currentOfficerReports.isEmpty) {
                        List {
                            
                            ForEach(currentOfficerReports.sorted(by: { $0.date > $1.date })) { report in
                                Button {
                                    selectedReport = report
                                    showReport = true
                                } label: {
                                    Text("Case Number: \(report.caseNumber)")
                                }
                                .foregroundStyle(colorScheme == .dark ? .white : .black)
                            }
                        }
                    }
                } else {
                    Text("No reports in database.")
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                
            }
        }
        .onAppear {
            currentOfficerReports = currentOfficer.currentOfficer.reports
        }
        .sheet(isPresented: Binding(
            get: { showReport },
            set: { showReport = $0 }
        )) {
            PriorReportView(selectedReport: selectedReport)
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        //let currentOfficer = Officer.previewOfficer
        let officerReport = Report.previewReportData
        
        return ReportsView(currentOfficerReports: [officerReport])
            .modelContainer(container)
    }
}
