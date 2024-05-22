//
//  PDFExport.swift
//  Dewie
//
//  Created by Thomas Hodge on 5/9/24.
//

import Foundation
import PDFKit

class ReportExport {
    
    static func savePDF(officer: Officer, report: Report) {
        // load the PDF file
        guard let url = Bundle.main.url(forResource: "DewieFormGFPD", withExtension: "pdf"),
              let pdfDocument = PDFDocument(url: url) else {
            print("PDF Not Found")
            return
        }
        // update annotations
        for pageNum in 0..<pdfDocument.pageCount {
            guard let page = pdfDocument.page(at: pageNum) else {
                continue
            }
            let annotations = page.annotations
            for annotation in annotations {
                switch annotation.fieldName {
                case "departmentName":
                    let placeholderValue = "\(officer.department)"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "officerID":
                    let placeholderValue = "\(officer.firstName) \(officer.lastName)"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "officerBadge":
                    let placeholderValue = "\(officer.badgeNumber)"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "caseNumber":
                    let placeholderValue = "\(report.caseNumber)"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "date":
                    let placeholderValue = "\(report.date)"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "equalPupilsize":
                    let placeholderValue = report.hgnTestResults?.equalPupilSize
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "noRestingNuystagmus":
                    let placeholderValue = report.hgnTestResults?.noRestingNystagmus
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "equalTracking":
                    let placeholderValue = report.hgnTestResults?.equalTracking
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "lackLeftEye":
                    let placeholderValue = report.hgnTestResults?.lackLeftEye
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "lackRightEye":
                    let placeholderValue = report.hgnTestResults?.lackRightEye
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "distinctLeftEye":
                    let placeholderValue = report.hgnTestResults?.distinctLeftEye
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "distinctRightEye":
                    let placeholderValue = report.hgnTestResults?.distinctRightEye
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "onsetLeftEye":
                    let placeholderValue = report.hgnTestResults?.onsetLeftEye
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "onsetRightEye":
                    let placeholderValue = report.hgnTestResults?.onsetRightEye
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "vgnNotPresent":
                    let placeholderValue = report.hgnTestResults?.vgnNotPresent
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "vgnPresent":
                    let placeholderValue = report.hgnTestResults?.vgnPresent
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "hgnNotes":
                    let placeholderValue = "\(report.hgnTestResults?.hgnNotes ?? "")"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "cannotRemainInStartingPosition":
                    let placeholderValue = report.walkAndTurnResults?.cannotRemainInStartingPosition
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "startsTooSoon":
                    let placeholderValue = report.walkAndTurnResults?.startsTooSoon
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "stepsOffLine":
                    let placeholderValue = report.walkAndTurnResults?.stepsOffTheLine
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "missesHeelToToe":
                    let placeholderValue = report.walkAndTurnResults?.missesHeelToToe
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "raisesArmForBalance":
                    let placeholderValue = report.walkAndTurnResults?.raisesArmForBalance
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "stops":
                    let placeholderValue = report.walkAndTurnResults?.stops
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "incorrectNumberOfSteps":
                    let placeholderValue = report.walkAndTurnResults?.incorrectNumberOfSteps
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "turnNotAsDescribed":
                    let placeholderValue = report.walkAndTurnResults?.turnNotAsDescribed
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "improperTurnDescription":
                    let placeholderValue = "\(report.walkAndTurnResults?.improperTurnDescription ?? "")"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "walkAndTurnNotes":
                    let placeholderValue = "\(report.walkAndTurnResults?.walkAndTurnNotes ?? "")"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "hops":
                    let placeholderValue = report.oneLegStandResults?.hops
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "putsFootDown":
                    let placeholderValue = report.oneLegStandResults?.putsFootDown
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "sways":
                    let placeholderValue = report.oneLegStandResults?.sways
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "raisesArmsForBalance":
                    let placeholderValue = report.walkAndTurnResults?.raisesArmForBalance
                    annotation.buttonWidgetState = placeholderValue ?? false ? .onState : .offState
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "oneLegStandNotes":
                    let placeholderValue = "\(report.oneLegStandResults?.oneLegStandNotes ?? "")"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                case "numberOfIncorrectSteps":
                    let placeholderValue = "\(report.walkAndTurnResults?.numberOfIncorrectNumberOfSteps ?? "0")"
                    annotation.setValue(placeholderValue, forAnnotationKey: .widgetValue)
                    page.removeAnnotation(annotation)
                    page.addAnnotation(annotation)
                default:
                    break
                }
            }
            
        }
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to access documents directory")
        }
        
        let destinationURL = documentsDirectory.appendingPathComponent("\(report.caseNumber).pdf")
        pdfDocument.write(to: destinationURL)
        
        //        if !officer.pdfExport {
        //            guard let image = convertPdfToImage(url: destinationURL) else { return }
        //
        //            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        //
        //        }
    }
    
    
    
    static func convertPdfToImage(url: URL) {
        guard let document = PDFDocument(url: url) else { return }

        guard let page = document.page(at: 0) else { return }
        
        let pageRect = page.bounds(for: .mediaBox)
        
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height))
            ctx.cgContext.translateBy(x: -pageRect.origin.x, y: pageRect.size.height - pageRect.origin.y)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            page.draw(with: .mediaBox, to: ctx.cgContext)
        }
        
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
            
            
            //        guard let document = CGPDFDocument(url as CFURL) else { return }
            //        guard let page = document.page(at: 1) else { return }
            //
            //        let pageRect = page.getBoxRect(.mediaBox)
            //        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
            //        let img = renderer.image { ctx in
            //            UIColor.white.set()
            //            ctx.fill(pageRect)
            //
            //            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            //            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            //
            //            ctx.cgContext.drawPDFPage(page)
            //            //page.draw(with: .mediaBox, to: ctx.cgContext)
            //        }
            //
            //        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
            
        }
    }
