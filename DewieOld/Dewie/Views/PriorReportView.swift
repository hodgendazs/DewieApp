//
//  PriorReportView.swift
//  Dewie
//
//  Created by Thomas Hodge on 4/1/24.
//

import SwiftUI

struct PriorReportView: View {
    let selectedReport: Report?
    let selectedOfficer: Officer?
    @State var exportedReportFile: URL?
    @State var exportedToCameraRoll: Bool = false
    
    var body: some View {
        
        VStack {
            if let selectedReport = selectedReport {
                Text("Report Id: \(selectedReport.id)")
                Text("Officer Id: \(selectedReport.officerId)")
                
                
                if let exportedPDF = exportedReportFile {
                    ShareLink("Export PDF", item: exportedPDF)
                        .buttonStyle(.borderedProminent)
                }
                Button("Export Image") {
                    if let exportedPDF = exportedReportFile {
                        ReportExport.convertPdfToImage(url: exportedPDF)
                    }
                    exportedToCameraRoll = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(exportedToCameraRoll)
            }
        }
        .onAppear {
            let exportedPDFLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            
            if let selectedReport = selectedReport {
                if let selectedOfficer = selectedOfficer {
                    ReportExport.savePDF(officer: selectedOfficer, report: selectedReport)
                }
            }
            
//            if selectedOfficer?.imageExport ?? false {
//                if let exportedPDFLocation {
//                    ReportExport.convertPdfToImage(url: exportedPDFLocation)
//                }
//            }
            
            exportedReportFile = exportedPDFLocation?.appendingPathComponent("\(selectedReport?.caseNumber ?? "").pdf")

        }
    }
}

//#Preview {
//    PriorReportView()
//}
