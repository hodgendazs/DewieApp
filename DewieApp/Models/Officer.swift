//
//  Officer.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import Foundation
import SwiftData

enum OfficerSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Officer.self]
    }
    
    @Model
    final class Officer {
        let id: UUID
        var licenseId: UUID?
        var lastAccessed: Date
        var firstName: String
        var lastName: String
        @Attribute(.unique) var badgeNumber: String
        var department: String
        var departmentEmail: String
        var pdfExport: Bool
        var imageExport: Bool
        var reports: [Report]
        
        init(id: UUID = UUID(), lastAccessed: Date, firstName: String, lastName: String, badgeNumber: String, department: String, departmentEmail: String, pdfExport: Bool, imageExport: Bool, reports: [Report]) {
            self.id = id
            self.lastAccessed = lastAccessed
            self.firstName = firstName
            self.lastName = lastName
            self.badgeNumber = badgeNumber
            self.department = department
            self.departmentEmail = departmentEmail
            self.pdfExport = pdfExport
            self.imageExport = imageExport
            self.reports = reports
        }
        
        func addReport(caseNumber: String, officerId: UUID, hgnTestResults: Report.HGN? = nil, walkAndTurnTestResults: Report.WalkAndTurn? = nil, oneLegStandTestResults: Report.OneLegStand?) {
            let report = Report(caseNumber: caseNumber, officerId: self.id, hgnTestResults: hgnTestResults, walkAndTurnResults: walkAndTurnTestResults, oneLegStandResults: oneLegStandTestResults)
            self.reports.append(report)
        }
        
        static let previewOfficerData = Officer(lastAccessed: Date(), firstName: "Test First Name", lastName: "Test Last Name", badgeNumber: "12345", department: "Test Department", departmentEmail: "test@email.com", pdfExport: true, imageExport: false, reports: [.previewReportData])
    }
}

// MARK: To be used at a later date if we need to migrate schemas to a new schema (lightweight if not a complex migration, custom if Uniques need to get resolved)
//enum OfficerMigrationPlan: SchemaMigrationPlan {
//    static var schemas: [any VersionedSchema.Type] {
//        [OfficerSchemaV1.self, OfficerSchemaV2.self]
//    }
//
//    static var stages: [MigrationStage] {
//        [migrateV1toV2]
//    }
//
//    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: OfficerSchemaV1.self, toVersion: OfficerSchemaV2.self)
//}
