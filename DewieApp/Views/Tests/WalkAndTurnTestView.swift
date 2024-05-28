//
//  WalkAndTurnTestView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/28/24.
//

import SwiftUI

struct WalkAndTurnTestView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var currentOfficer: Officer
    let caseNumber: String
    let dateTime: String
    
    @State var startsTooSoon: Bool = false
    @State var cannotRemainInStartingPosition: Bool = false
    
    @State var stepsOffLine: Bool = false
    @State var missesHeelToToe: Bool = false
    @State var raisesArmForBalance: Bool = false
    @State var stops: Bool = false
    @State var incorrectNumberOfSteps: Bool = false
    @State var numberOfIncorrectSteps: String = ""
    @State var turnNotAsDescribed: Bool = false
    @State var improperTurnDescription: String = ""
    
    @State var walkAndTurnNotes: String = ""
    
    @State var submitWalkAndTurn: Bool = false
    @Binding var walkAndTurnTestComplete: Bool
    @Binding var walkAndTurnTestResults: Report.WalkAndTurn?
    
    
    
    var body: some View {
        VStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    Text(caseNumber)
                        .font(.title)
                        .bold()
                    Text(dateTime)
                        .textScale(.secondary)
                        .bold()
                }
                .foregroundStyle(.white)
                .padding(25)
            }
            .frame(height: 75)
            
            TabView {
                WalkAndTurnInstructionTab1()
                
                
                WalkAndTurnTestResultsTab(startsTooSoon: $startsTooSoon, cannotRemainInStartingPosition: $cannotRemainInStartingPosition, stepsOffLine: $stepsOffLine, missesHeelToToe: $missesHeelToToe, raisesArmForBalance: $raisesArmForBalance, stops: $stops, incorrectNumberOfSteps: $incorrectNumberOfSteps, numberOfIncorrectSteps: $numberOfIncorrectSteps, turnNotAsDescribed: $turnNotAsDescribed, improperTurnDescription: $improperTurnDescription)
                
                WalkAndTurnNotesTab(walkAndTurnNotes: $walkAndTurnNotes, submitWalkAndTurn: $submitWalkAndTurn)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .background(.black)
        }
        .onChange(of: submitWalkAndTurn) {
            print(walkAndTurnNotes)
            walkAndTurnTestResults = Report.WalkAndTurn(startsTooSoon: startsTooSoon, cannotRemainInStartingPosition: cannotRemainInStartingPosition, stepsOffTheLine: stepsOffLine, missesHeelToToe: missesHeelToToe, raisesArmForBalance: raisesArmForBalance, stops: stops, incorrectNumberOfSteps: incorrectNumberOfSteps, numberOfIncorrectNumberOfSteps: numberOfIncorrectSteps, turnNotAsDescribed: turnNotAsDescribed, improperTurnDescription: improperTurnDescription, walkAndTurnNotes: walkAndTurnNotes)
            walkAndTurnTestComplete = true
            dismiss()
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        
        return WalkAndTurnTestView(currentOfficer: .constant(.previewOfficerData), caseNumber: "24-1111", dateTime: Date().formatted(date: .abbreviated, time: .shortened), walkAndTurnTestComplete: .constant(false), walkAndTurnTestResults: .constant(nil))
            .modelContainer(container)
    }
}

struct WalkAndTurnInstructionTab1: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Walk and Turn Instruction")
                .padding(.vertical)
                .font(.largeTitle)
                .bold()
                .textScale(.secondary)
            
            Text("(Scroll down)")
                .padding(.vertical)
            
            Divider()
                .frame(height: 2)
                .overlay(.black)
            ScrollView {
                VStack(alignment: .leading) {
                    Text("1. You are going to pretend there is a straight line directly in front of you.")
                        .padding(.vertical, 25)
                    Text("2. Put you left foot on the line, then place your right foot on the line ahead of your left, with the heel of your right foot against the toe of your left. (DEMONSTRATE)")
                        .padding(.vertical, 25)
                    Text("3. Do not start until I tell you to do so.")
                        .padding(.vertical, 25)
                    Text("4. Do you understand?")
                        .padding(.vertical, 25)
                    Text("5. When I tell you to begin, take 9 heel-to-toe steps on the line.")
                        .padding(.vertical, 25)
                    Text("6. When you reach the 9th step, keep your front foot on the line and turn taking several small steps with the other foot. Then take 9 heel-to-toe steps back down the line. (DEMONSTRATE)")
                        .padding(.vertical, 25)
                    Text("7. Keep your arms at your sides at all times, watch your feet, and count each step out loud. Once you begin walking, do not stop until you have completed the test.")
                        .padding(.vertical, 25)
                    Text("8. Do you understand the instructions?")
                        .padding(.vertical, 25)
                    Text("9. You may begin.")
                        //.padding(.bottom, 50)

                }
                .font(.title)
                .padding(.horizontal)
            }
            .frame(height: 525)
            Spacer()
        }
        .foregroundStyle(.white)
        .padding()
    }
}

struct WalkAndTurnTestResultsTab: View {
    @Binding var startsTooSoon: Bool
    @Binding var cannotRemainInStartingPosition: Bool
    
    @Binding var stepsOffLine: Bool
    @Binding var missesHeelToToe: Bool
    @Binding var raisesArmForBalance: Bool
    @Binding var stops: Bool
    @Binding var incorrectNumberOfSteps: Bool
    @Binding var numberOfIncorrectSteps: String
    @Binding var turnNotAsDescribed: Bool
    @Binding var improperTurnDescription: String
    
    var body: some View {
        VStack {
            Text("Walk and Turn - Scoring")
                .foregroundStyle(.white)
                .padding(.vertical)
                .font(.largeTitle)
                .bold()
                .textScale(.secondary)
            
            Divider()
                .frame(height: 2)
                .overlay(.black)
            
            Form {
                Section {
                    Toggle("Starts Too Soon", isOn: $startsTooSoon)
                    Toggle("Cannot Remain In Starting Position", isOn: $cannotRemainInStartingPosition)
                } header: {
                    Text("Instruction Phase")
                }
                
                Section {
                    Toggle("Steps Off Line", isOn: $stepsOffLine)
                    Toggle("Misses Heel-To-Toe ( > 1/2\" )", isOn: $missesHeelToToe)
                    Toggle("Raises Arm(s) For Balance", isOn: $raisesArmForBalance)
                    Toggle("Stops", isOn: $stops)
                    Toggle("Incorrect # Of Steps", isOn: $incorrectNumberOfSteps)
                    if incorrectNumberOfSteps {
                        TextField("Number of Steps", text: $numberOfIncorrectSteps)
                    }
                    Toggle("Turn Not As Described", isOn: $turnNotAsDescribed)
                    if turnNotAsDescribed {
                        TextField("Turn Description", text: $improperTurnDescription)
                    }
                } header: {
                    Text("Performance Phase")
                }
            }
            .frame(height: 550)
        }
    }
}

struct WalkAndTurnNotesTab: View {
    @Binding var walkAndTurnNotes: String
    @Binding var submitWalkAndTurn: Bool
    
    var body: some View {
        VStack {
            Text("Walk And Turn - Observations")
                .padding(.top, 50)
            
            TextEditor(text: $walkAndTurnNotes)
                .scrollContentBackground(.hidden)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 7.0))
                .padding()
                .foregroundStyle(.black)
                
            
            Button {
                submitWalkAndTurn = true
            } label: {
                Text("Submit Walk And Turn Results")
                    .foregroundStyle(.black)
            }
            .padding(.top, 10)
            .padding(.bottom, 125)
            .buttonStyle(.borderedProminent)
            .tint(.white)
            
        }
        .foregroundStyle(.white)
    }
}
