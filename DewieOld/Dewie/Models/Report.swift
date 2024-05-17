import Foundation
import SwiftData

@Model
class Report {
    var id = UUID()
    var caseNumber: String
    var officerId: UUID
    var date = Date()
    var hgnTestResults: HGN?
    var walkAndTurnResults: WalkAndTurn?
    var oneLegStandResults: OneLegStand?
    
    init(id: UUID = UUID(), caseNumber: String, officerId: UUID, date: Date = Date(), hgnTestResults: HGN? = nil, walkAndTurnResults: WalkAndTurn? = nil, oneLegStandResults: OneLegStand? = nil) {
        self.id = id
        self.caseNumber = caseNumber
        self.officerId = officerId
        self.date = date
        self.hgnTestResults = hgnTestResults
        self.walkAndTurnResults = walkAndTurnResults
        self.oneLegStandResults = oneLegStandResults
    }
    
    @Model
    class HGN {
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
    class WalkAndTurn {
        var startsTooSoon: Bool
        var cannotRemainInStartingPosition: Bool
        var stepsOffLine: Bool
        var missesHeelToToe: Bool
        var raisesArmForBalance: Bool
        var stops: Bool
        var incorrectNumberOfSteps: Bool
        var numberOfIncorrectSteps: String
        var turnNotAsDescribed: Bool
        var improperTurnDescription: String
        var walkAndTurnNotes: String
        
        init(startsTooSoon: Bool, cannotRemainInStartingPosition: Bool, stepsOffLine: Bool, missesHeelToToe: Bool, raisesArmForBalance: Bool, stops: Bool, incorrectNumberOfSteps: Bool, numberOfIncorrectSteps: String, turnNotAsDescribed: Bool, improperTurnDescription: String, walkAndTurnNotes: String) {
            self.startsTooSoon = startsTooSoon
            self.cannotRemainInStartingPosition = cannotRemainInStartingPosition
            self.stepsOffLine = stepsOffLine
            self.missesHeelToToe = missesHeelToToe
            self.raisesArmForBalance = raisesArmForBalance
            self.stops = stops
            self.incorrectNumberOfSteps = incorrectNumberOfSteps
            self.numberOfIncorrectSteps = numberOfIncorrectSteps
            self.turnNotAsDescribed = turnNotAsDescribed
            self.improperTurnDescription = improperTurnDescription
            self.walkAndTurnNotes = walkAndTurnNotes
        }
    }
    
    @Model
    class OneLegStand {
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
    
    static let previewReport = Report(caseNumber: "24-1111", officerId: UUID(), hgnTestResults: Report.HGN(equalPupilSize: false, noRestingNystagmus: false, equalTracking: false, lackLeftEye: false, lackRightEye: false, distinctLeftEye: false, distinctRightEye: false, onsetLeftEye: false, onsetRightEye: false, vgnNotPresent: true, vgnPresent: false, hgnNotes: "HGN Preview Notes"), walkAndTurnResults: Report.WalkAndTurn(startsTooSoon: false, cannotRemainInStartingPosition: false, stepsOffLine: false, missesHeelToToe: false, raisesArmForBalance: false, stops: false, incorrectNumberOfSteps: false, numberOfIncorrectSteps: "1", turnNotAsDescribed: false, improperTurnDescription: "Turned like Michael Jackson", walkAndTurnNotes: "Walk and Turn Preview Notes"), oneLegStandResults: Report.OneLegStand(putsFootDown: false, sways: false, raisesArmsForBalance: false, hops: false, oneLegStandNotes: "One Leg Stand Preview Notes"))
    
}






//class Report {
//    var id = UUID()
//    var caseNumber: String
//    var officerId: UUID
//    var timeSince1970: TimeInterval
//    var hgn: HGN?
//    var walkAndTurn: WalkAndTurn?
//    var oneLegStand: OneLegStand?
//
//    init(caseNumber: String, officerId: UUID, timeSince1970: TimeInterval, hgn: HGN? = nil, walkAndTurn: WalkAndTurn? = nil, oneLegStand: OneLegStand? = nil) {
//        self.caseNumber = caseNumber
//        self.officerId = id
//        self.timeSince1970 = timeSince1970
//        self.hgn = hgn
//        self.walkAndTurn = walkAndTurn
//        self.oneLegStand = oneLegStand
//    }
//
//    class HGN {
//        var equalEyePupilSize: Bool
//        var noRestingNystagmus: Bool
//        var equalEyeTracking: Bool
//        var lackOfSmoothPursuit: LackOfSmoothPursuit?
//        var distinctAndSustainedNystagmusAtMaximumDeviation: DistinctAndSustainedNystagmusAtMaximumDeviation?
//        var onsetOfNystagmusPriorTo45: OnsetOfNystagmusPriorTo45?
//        var hgnNotes: HGNNotes?
//
//        init(equalEyePupilSize: Bool, noRestingNystagmus: Bool, equalEyeTracking: Bool, lackOfSmoothPursuit: LackOfSmoothPursuit? = nil, distinctAndSustainedNystagmusAtMaximumDeviation: DistinctAndSustainedNystagmusAtMaximumDeviation? = nil, onsetOfNystagmusPriorTo45: OnsetOfNystagmusPriorTo45? = nil, hgnNotes: HGNNotes? = nil) {
//            self.equalEyePupilSize = equalEyePupilSize
//            self.noRestingNystagmus = noRestingNystagmus
//            self.equalEyeTracking = equalEyeTracking
//            self.lackOfSmoothPursuit = lackOfSmoothPursuit
//            self.distinctAndSustainedNystagmusAtMaximumDeviation = distinctAndSustainedNystagmusAtMaximumDeviation
//            self.onsetOfNystagmusPriorTo45 = onsetOfNystagmusPriorTo45
//            self.hgnNotes = hgnNotes
//        }
//
//        class LackOfSmoothPursuit {
//            var description: String = "Move stimulus from center to maximum deviation, starting with the left eye (2 seconds from the center to side)."
//            var leftEye: Bool
//            var rightEye: Bool
//
//            init(description: String, leftEye: Bool, rightEye: Bool) {
//                self.description = description
//                self.leftEye = leftEye
//                self.rightEye = rightEye
//            }
//        }
//
//        class DistinctAndSustainedNystagmusAtMaximumDeviation {
//            var description: String = "Move stimulus from center to maximum deviation, starting with the left eye (2 seconds from the center to side), hold at maximum deviation for a MINUMUM of 4 seconds."
//            var leftEye: Bool
//            var rightEye: Bool
//
//            init(description: String, leftEye: Bool, rightEye: Bool) {
//                self.description = description
//                self.leftEye = leftEye
//                self.rightEye = rightEye
//            }
//        }
//
//        class OnsetOfNystagmusPriorTo45 {
//            var description: String = "Slowly (4 second pass) move stimulus from center to 45 degrees. If/when Nystagmus is present, move on to the next eye."
//            var leftEye: Bool
//            var rightEye: Bool
//
//            init(description: String, leftEye: Bool, rightEye: Bool) {
//                self.description = description
//                self.leftEye = leftEye
//                self.rightEye = rightEye
//            }
//        }
//
//        class HGNNotes {
//            var notes: String
//
//            init(notes: String) {
//                self.notes = notes
//            }
//        }
//    }
//
//    class WalkAndTurn {
//        var instructionPhase: InstructionPhase?
//        var performancePhase: PerformancePhase?
//        var walkAndTurnNotes: WalkAndTurnNotes?
//
//        class InstructionPhase {
//            var startsTooSoon: Bool
//            var cannotRemainInStartingPosition: Bool
//
//            init(startsTooSoon: Bool, cannotRemainInStartingPosition: Bool) {
//                self.startsTooSoon = startsTooSoon
//                self.cannotRemainInStartingPosition = cannotRemainInStartingPosition
//            }
//        }
//
//        class PerformancePhase {
//            var stepsOffLine: Bool
//            var missesHeelToToe: Bool
//            var raisesArmsForBalance: Bool
//            var stops: Bool
//            var incorrectNumberOfSteps: Bool
//            var numberOfIncorrectSteps: String?
//            var turnNotAsDescribed: Bool
//            var improperTurnDescription: String?
//
//            init(stepsOffLine: Bool, missesHeelToToe: Bool, raisesArmsForBalance: Bool, stops: Bool, incorrectNumberOfSteps: Bool, numberOfIncorrectSteps: String? = nil, turnNotAsDescribed: Bool, improperTurnDescription: String? = nil) {
//                self.stepsOffLine = stepsOffLine
//                self.missesHeelToToe = missesHeelToToe
//                self.raisesArmsForBalance = raisesArmsForBalance
//                self.stops = stops
//                self.incorrectNumberOfSteps = incorrectNumberOfSteps
//                self.numberOfIncorrectSteps = numberOfIncorrectSteps
//                self.turnNotAsDescribed = turnNotAsDescribed
//                self.improperTurnDescription = improperTurnDescription
//            }
//        }
//
//        class WalkAndTurnNotes {
//            var notes: String
//
//            init(notes: String) {
//                self.notes = notes
//            }
//        }
//    }
//
//    class OneLegStand {
//        var putsFootDown: Bool
//        var sways: Bool
//        var raisesArmsForBalance: Bool
//        var hops: Bool
//        var oneLegStandNotes: OneLegStandNotes?
//
//        init(putsFootDown: Bool, sways: Bool, raisesArmsForBalance: Bool, hops: Bool, oneLegStandNotes: OneLegStandNotes? = nil) {
//            self.putsFootDown = putsFootDown
//            self.sways = sways
//            self.raisesArmsForBalance = raisesArmsForBalance
//            self.hops = hops
//            self.oneLegStandNotes = oneLegStandNotes
//        }
//
//        class OneLegStandNotes {
//            var notes: String
//
//            init(notes: String) {
//                self.notes = notes
//            }
//        }
//    }
//}
