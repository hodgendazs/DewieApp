//
//  Report.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import Foundation
import SwiftData

enum ReportSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [Report.self]
    }
    
    @Model
    final class Report {
        var id: UUID
        var caseNumber: String
        var officerId: UUID
        var date: String
        var hgnTestResults: HGN?
        var walkAndTurnResults: WalkAndTurn?
        var oneLegStandResults: OneLegStand?
        
        init(id: UUID = UUID(), caseNumber: String, officerId: UUID, date: String, hgnTestResults: HGN? = nil, walkAndTurnResults: WalkAndTurn? = nil, oneLegStandResults: OneLegStand? = nil) {
            self.id = id
            self.caseNumber = caseNumber
            self.officerId = officerId
            self.date = date
            self.hgnTestResults = hgnTestResults
            self.walkAndTurnResults = walkAndTurnResults
            self.oneLegStandResults = oneLegStandResults
        }
        
        @Model
        final class HGN {
            var equalPupilSize: Bool
            var noRestingNystagmus: Bool
            var equalTracking: Bool
            var lackLeftEye: Bool
            var lackRightEye: Bool
            var distinctLeftEye: Bool
            var distinctRightEye: Bool
            var onsetLeftEye: Bool
            var onsetRightEye: Bool
            var vgnNotPresent: Bool
            var vgnPresent: Bool
            var hgnNotes: String
            
            init(equalPupilSize: Bool, noRestingNystagmus: Bool, equalTracking: Bool, lackLeftEye: Bool, lackRightEye: Bool, distinctLeftEye: Bool, distinctRightEye: Bool, onsetLeftEye: Bool, onsetRightEye: Bool, vgnNotPresent: Bool, vgnPresent: Bool, hgnNotes: String) {
                self.equalPupilSize = equalPupilSize
                self.noRestingNystagmus = noRestingNystagmus
                self.equalTracking = equalTracking
                self.lackLeftEye = lackLeftEye
                self.lackRightEye = lackRightEye
                self.distinctLeftEye = distinctLeftEye
                self.distinctRightEye = distinctRightEye
                self.onsetLeftEye = onsetLeftEye
                self.onsetRightEye = onsetRightEye
                self.vgnNotPresent = vgnNotPresent
                self.vgnPresent = vgnPresent
                self.hgnNotes = hgnNotes
            }
        }
        
        @Model
        final class WalkAndTurn {
            var startsTooSoon: Bool
            var cannotRemainInStartingPosition: Bool
            var stepsOffTheLine: Bool
            var missesHeelToToe: Bool
            var raisesArmForBalance: Bool
            var stops: Bool
            var incorrectNumberOfSteps: Bool
            var numberOfIncorrectNumberOfSteps: String
            var turnNotAsDescribed: Bool
            var improperTurnDescription: String
            var walkAndTurnNotes: String
            
            init(startsTooSoon: Bool, cannotRemainInStartingPosition: Bool, stepsOffTheLine: Bool, missesHeelToToe: Bool, raisesArmForBalance: Bool, stops: Bool, incorrectNumberOfSteps: Bool, numberOfIncorrectNumberOfSteps: String, turnNotAsDescribed: Bool, improperTurnDescription: String, walkAndTurnNotes: String) {
                self.startsTooSoon = startsTooSoon
                self.cannotRemainInStartingPosition = cannotRemainInStartingPosition
                self.stepsOffTheLine = stepsOffTheLine
                self.missesHeelToToe = missesHeelToToe
                self.raisesArmForBalance = raisesArmForBalance
                self.stops = stops
                self.incorrectNumberOfSteps = incorrectNumberOfSteps
                self.numberOfIncorrectNumberOfSteps = numberOfIncorrectNumberOfSteps
                self.turnNotAsDescribed = turnNotAsDescribed
                self.improperTurnDescription = improperTurnDescription
                self.walkAndTurnNotes = walkAndTurnNotes
            }
        }
        
        @Model
        final class OneLegStand {
            var putsFootDown: Bool
            var sways: Bool
            var raisesArmsForBalance: Bool
            var hops: Bool
            var oneLegStandNotes: String
            
            init(putsFootDown: Bool, sways: Bool, raisesArmsForBalance: Bool, hops: Bool, oneLegStandNotes: String) {
                self.putsFootDown = putsFootDown
                self.sways = sways
                self.raisesArmsForBalance = raisesArmsForBalance
                self.hops = hops
                self.oneLegStandNotes = oneLegStandNotes
            }
        }
        
        static let previewReportData = Report(caseNumber: "12-345", officerId: UUID(), date: "TEST DATE", hgnTestResults: Report.HGN(equalPupilSize: false, noRestingNystagmus: false, equalTracking: false, lackLeftEye: false, lackRightEye: false, distinctLeftEye: false, distinctRightEye: false, onsetLeftEye: false, onsetRightEye: false, vgnNotPresent: true, vgnPresent: false, hgnNotes: "HGN NOTES"), walkAndTurnResults: Report.WalkAndTurn(startsTooSoon: false, cannotRemainInStartingPosition: false, stepsOffTheLine: false, missesHeelToToe: false, raisesArmForBalance: false, stops: false, incorrectNumberOfSteps: false, numberOfIncorrectNumberOfSteps: "0", turnNotAsDescribed: false, improperTurnDescription: "", walkAndTurnNotes: "WALK AND TURN NOTES"), oneLegStandResults: Report.OneLegStand(putsFootDown: false, sways: false, raisesArmsForBalance: false, hops: false, oneLegStandNotes: "ONE LEG STAND NOTES"))
    }
}

// MARK: To be used at a later date if we need to migrate schemas to a new schema (lightweight if not a complex migration, custom if Uniques need to get resolved)
//enum ReportMigrationPlan: SchemaMigrationPlan {
//    static var schemas: [any VersionedSchema.Type] {
//        [ReportSchemaV1.self, ReportSchemaV2.self]
//    }
//
//    static var stages: [MigrationStage] {
//        [migrateV1toV2]
//    }
//
//    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: ReportSchemaV1.self, toVersion: ReportSchemaV2.self)
//}
