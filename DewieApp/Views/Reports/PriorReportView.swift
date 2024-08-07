//
//  PriorReportView.swift
//  Dewie
//
//  Created by Thomas Hodge on 4/1/24.
//

//import SwiftUI
//import PDFKit
//
//struct PriorReportView: View {
//    @EnvironmentObject var officerManager: OfficerManager
//    @EnvironmentObject var reportManager: ReportManager
//    @State var exportedReportFile: URL?
//    @State var exportedToCameraRoll: Bool = false
//
//    var body: some View {
//
//        VStack {
//            Text("Prior Report")
//            Text("Case Number: \(reportManager.selectedReport?.caseNumber ?? "")")
//            Text("Officer Id: \(officerManager.currentOfficer?.id ?? UUID())")
//            Text("Report Officer Id: \(reportManager.selectedReport?.officerId ?? UUID())")
//            Text("Report Date: \(reportManager.selectedReport?.date ?? "No Date")")
//
//            if let exportedPDF = exportedReportFile {
//                ShareLink("Export PDF", item: exportedPDF)
//                    .buttonStyle(.borderedProminent)
//            }
//
//
//            Button("Export Image") {
//                if let exportedPDF = exportedReportFile {
//                    ReportExport.convertPdfToImage(url: exportedPDF)
//                }
//                exportedToCameraRoll = true
//            }
//            .buttonStyle(.borderedProminent)
//            .disabled(exportedToCameraRoll)
//        }
//        .onAppear {
//            let exportedPDFLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//
//            if let report = reportManager.selectedReport {
//                if let officer = officerManager.currentOfficer {
//                    ReportExport.savePDF(officer: officer, report: report)
//                    exportedReportFile = exportedPDFLocation?.appendingPathComponent("\(report.caseNumber).pdf")
//                }
//            }
//        }
//    }
//}

import SwiftUI
import PDFKit

struct PriorReportView: View {
    @EnvironmentObject var officerManager: OfficerManager
    @EnvironmentObject var reportManager: ReportManager
    @State var exportedReportFile: URL?
    @State var exportedImageFile: URL?
    @State var exportedToCameraRoll: Bool = false
    
    var body: some View {
        VStack {
            if let exportedImageFile = exportedImageFile, let uiImage = UIImage(contentsOfFile: exportedImageFile.path) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 400)
            } else {
                Text("Prior Report")
                Text("Case Number: \(reportManager.selectedReport?.caseNumber ?? "")")
                Text("Officer Id: \(officerManager.currentOfficer?.id ?? UUID())")
                Text("Report Officer Id: \(reportManager.selectedReport?.officerId ?? UUID())")
                Text("Report Date: \(reportManager.selectedReport?.date ?? "No Date")")
            }
            
            if let exportedPDF = exportedReportFile {
                ShareLink("Export PDF", item: exportedPDF)
                    .buttonStyle(.borderedProminent)
            }
            
            Button("Export Image") {
                if let exportedPDF = exportedReportFile {
                    exportedImageFile = ReportExport.convertPdfToImage(url: exportedPDF)
                }
                exportedToCameraRoll = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(exportedToCameraRoll)
        }
        .onAppear {
            if let exportedPDF = exportedReportFile {
                exportedImageFile = ReportExport.convertPdfToImage(url: exportedPDF)
            }
            
            let exportedPDFLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            
            if let report = reportManager.selectedReport {
                if let officer = officerManager.currentOfficer {
                    ReportExport.savePDF(officer: officer, report: report)
                    exportedReportFile = exportedPDFLocation?.appendingPathComponent("\(report.caseNumber).pdf")
                }
            }
        }
        .onChange(of: exportedImageFile, { oldValue, newValue in
            if newValue != nil {
                print("image file update")
            }
        })
    }
}

//#Preview {
//    PriorReportView()
//}


//#Preview {
//    PriorReportView()
//}
