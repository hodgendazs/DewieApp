//
//  PreviewSwiftData.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/20/24.
//

import Foundation
import SwiftData

@MainActor
let multipleOfficerPreviewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Officer.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        
        
        for index in 0..<10 {
            let newOfficer = Officer(id: UUID(), lastAccessed: Date(), firstName: "FirstName #\(index)", lastName: "LastName #\(index)", badgeNumber: "\(index)", department: "Department #\(index)", departmentEmail: "email\(index)@email.com", departmentCode: "", pdfExport: true, imageExport: false, reports: [])
            container.mainContext.insert(newOfficer)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

@MainActor
let singleOfficerPreviewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Officer.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let officer = Officer(lastAccessed: Date(), firstName: "Thomas", lastName: "Hodge", badgeNumber: "8675309", department: "Test Department", departmentEmail: "test@email.com", departmentCode: "", pdfExport: true, imageExport: false, reports: [Report(caseNumber: "24-1111", officerId: UUID(), date: "TEST DATE", hgnTestResults: Report.HGN(equalPupilSize: false, noRestingNystagmus: false, equalTracking: false, lackLeftEye: false, lackRightEye: false, distinctLeftEye: false, distinctRightEye: false, onsetLeftEye: false, onsetRightEye: false, vgnNotPresent: true, vgnPresent: false, hgnNotes: "HGN Preview Notes"), walkAndTurnResults: Report.WalkAndTurn(startsTooSoon: false, cannotRemainInStartingPosition: false, stepsOffTheLine: false, missesHeelToToe: false, raisesArmForBalance: false, stops: false, incorrectNumberOfSteps: false, numberOfIncorrectNumberOfSteps: "1", turnNotAsDescribed: false, improperTurnDescription: "Turned like Michael Jackson", walkAndTurnNotes: "Walk and Turn Preview Notes"))])
        container.mainContext.insert(officer)
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
