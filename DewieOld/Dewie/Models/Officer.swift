//
//  OfficerInformation.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/12/24.
//

import Foundation
import SwiftData

enum OfficerSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Officer.self]
    }
    
    @Model
    class Officer {
        
        let id: UUID
        var lastAccessed: Date
        var firstName: String
        var lastName: String
        @Attribute(.unique) var badgeNumber: String
        var department: String
        var departmentEmail: String
        var lackOfConvergence: Bool
        var modifiedRomberg: Bool
        var fingerToNose: Bool
        var reports: [Report]
        
        init(id: UUID = UUID(), lastAccessed: Date, firstName: String, lastName: String, badgeNumber: String, department: String, departmentEmail: String, lackOfConvergence: Bool, modifiedRomberg: Bool, fingerToNose: Bool, reports: [Report]) {
            self.id = id
            self.lastAccessed = lastAccessed
            self.firstName = firstName
            self.lastName = lastName
            self.badgeNumber = badgeNumber
            self.department = department
            self.departmentEmail = departmentEmail
            self.lackOfConvergence = lackOfConvergence
            self.modifiedRomberg = modifiedRomberg
            self.fingerToNose = fingerToNose
            self.reports = reports
        }
        func addReport(caseNumber: String, officerId: UUID, hgnTestResults: Report.HGN? = nil, walkAndTurnTestResults: Report.WalkAndTurn? = nil, oneLegStandResults: Report.OneLegStand? = nil) {
            let report = Report(caseNumber: caseNumber, officerId: self.id, hgnTestResults: hgnTestResults, walkAndTurnResults: walkAndTurnTestResults, oneLegStandResults: oneLegStandResults)
            self.reports.append(report)
        }
        
        static let previewOfficer = Officer(lastAccessed: Date(), firstName: "Thomas", lastName: "Hodge", badgeNumber: "1234", department: "Test Department", departmentEmail: "test@email.com", lackOfConvergence: false, modifiedRomberg: false, fingerToNose: false, reports: [.previewReport])
    }
}

enum OfficerSchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Officer.self]
    }
    
    @Model
    class Officer {
        
        let id: UUID
        var lastAccessed: Date
        var firstName: String
        var lastName: String
        @Attribute(.unique) var badgeNumber: String
        var department: String
        var departmentEmail: String
        var lackOfConvergence: Bool
        var modifiedRomberg: Bool
        var fingerToNose: Bool
        var pdfExport: Bool = true
        var imageExport: Bool = false
        var reports: [Report]
        
        init(id: UUID = UUID(), lastAccessed: Date, firstName: String, lastName: String, badgeNumber: String, department: String, departmentEmail: String, lackOfConvergence: Bool, modifiedRomberg: Bool, fingerToNose: Bool, pdfExport: Bool = true, imageExport: Bool = false, reports: [Report]) {
            self.id = id
            self.lastAccessed = lastAccessed
            self.firstName = firstName
            self.lastName = lastName
            self.badgeNumber = badgeNumber
            self.department = department
            self.departmentEmail = departmentEmail
            self.lackOfConvergence = lackOfConvergence
            self.modifiedRomberg = modifiedRomberg
            self.fingerToNose = fingerToNose
            self.pdfExport = pdfExport
            self.imageExport = imageExport
            self.reports = reports
        }
        func addReport(caseNumber: String, officerId: UUID, hgnTestResults: Report.HGN? = nil, walkAndTurnTestResults: Report.WalkAndTurn? = nil, oneLegStandResults: Report.OneLegStand? = nil) {
            let report = Report(caseNumber: caseNumber, officerId: self.id, hgnTestResults: hgnTestResults, walkAndTurnResults: walkAndTurnTestResults, oneLegStandResults: oneLegStandResults)
            self.reports.append(report)
        }
        
        static let previewOfficer = Officer(lastAccessed: Date(), firstName: "Thomas", lastName: "Hodge", badgeNumber: "1234", department: "Test Department", departmentEmail: "test@email.com", lackOfConvergence: false, modifiedRomberg: false, fingerToNose: false, pdfExport: true, imageExport: false, reports: [.previewReport])
    }
}

enum OfficerMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [OfficerSchemaV1.self, OfficerSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: OfficerSchemaV1.self, toVersion: OfficerSchemaV2.self)
}
