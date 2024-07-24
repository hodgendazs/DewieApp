//
//  NewReportView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/28/24.
//

import SwiftUI
import SwiftData

struct NewReportView: View {
    @Environment(\.modelContext) var modelContext
    
    @State var currentOfficer: Officer
    
    @State var caseNumber: String = ""
    @State var dateTime: String = Date().formatted(date: .abbreviated, time: .shortened)
    
    @State var hgnTest: Bool = false
    @State var hgnTestComplete: Bool = false
    @State var hgnTestResults: Report.HGN?
    @State var walkAndTurnTest: Bool = false
    @State var walkAndTurnTestComplete: Bool = false
    @State var walkAndTurnTestResults: Report.WalkAndTurn?
    @State var oneLegStandTest: Bool = false
    @State var oneLegStandTestComplete: Bool = false
    @State var oneLegStandTestResults: Report.OneLegStand?
    
    @State var caseNumberSet: Bool = false
    @State var reportSubmitted: Bool = false
    @State var cancelReport: Bool = false
    
    private var readyToSubmit: Bool {
        !hgnTestComplete || !walkAndTurnTestComplete || !oneLegStandTestComplete
    }
    
    var body: some View {
        ZStack {
            VStack {
                if !caseNumberSet {
                    Form {
                        Section(header: Text("New Report Info || \(dateTime)")) {
                            TextField("Case Number", text: $caseNumber)
                                .keyboardType(.numbersAndPunctuation)
                                .disabled(caseNumberSet)
                            HStack {
                                Spacer()
                                Button {
                                    caseNumberSet = true
                                } label: {
                                    Text("Submit")
                                }
                                Spacer()
                            }
                        }
                        
                    }
                    
                } else {
                    Text("Case Number: \(caseNumber)")
                }
                
                if caseNumberSet {
                    Form {
                        Section(header: Text("Tests Available")) {
                            
                            Test(shouldPresent: $hgnTest, shouldComplete: $hgnTestComplete, testName: "HGN")
                                .disabled(hgnTestComplete || !caseNumberSet)
                            Test(shouldPresent: $walkAndTurnTest, shouldComplete: $walkAndTurnTestComplete, testName: "Walk and Turn")
                                .disabled(walkAndTurnTestComplete || !caseNumberSet)
                            Test(shouldPresent: $oneLegStandTest, shouldComplete: $oneLegStandTestComplete, testName: "One Leg Stand")
                                .disabled(oneLegStandTestComplete || !caseNumberSet)
                            HStack {
                                Spacer()
                                Button {
                                    currentOfficer.addReport(caseNumber: caseNumber, officerId: currentOfficer.id, hgnTestResults: hgnTestResults, walkAndTurnTestResults: walkAndTurnTestResults, oneLegStandTestResults: oneLegStandTestResults)
                                    print(hgnTestComplete)
                                    print(walkAndTurnTestComplete)
                                    reportSubmitted = true
                                } label: {
                                    Text("Submit Report")
                                }
                                .disabled(readyToSubmit)
                                .navigationDestination(isPresented: $reportSubmitted) {
                                    HomeScreen()
                                        .navigationBarBackButtonHidden(true)
                                }
                                Spacer()
                            }
                            
                            
                        }
                        Section {
                            HStack {
                                Spacer()
                                Button {
                                    cancelReport = true
                                } label: {
                                    Text("Cancel Report")
                                        .tint(.red)
                                }
                                .navigationDestination(isPresented: $cancelReport) {
                                    HomeScreen()
                                        .navigationBarBackButtonHidden(true)
                                }
                                Spacer()
                            }
                        }
                    }
                    
                }
            }
        }
        .sheet(isPresented: $hgnTest, content: {
            HGNTestView(currentOfficer: $currentOfficer, caseNumber: caseNumber, dateTime: dateTime, hgnTestComplete: $hgnTestComplete, hgnTestResults: $hgnTestResults)
        })
        .sheet(isPresented: $walkAndTurnTest, content: {
            WalkAndTurnTestView(currentOfficer: $currentOfficer, caseNumber: caseNumber, dateTime: dateTime, walkAndTurnTestComplete: $walkAndTurnTestComplete, walkAndTurnTestResults: $walkAndTurnTestResults)
        })
        .sheet(isPresented: $oneLegStandTest, content: {
            OneLegStandTestView(currentOfficer: $currentOfficer, caseNumber: caseNumber, dateTime: dateTime, oneLegStandTestComplete: $oneLegStandTestComplete, oneLegStandTestResults: $oneLegStandTestResults)
        })
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        let currentOfficer = Officer.previewOfficerData
        
        return NewReportView(currentOfficer: currentOfficer)
            .modelContainer(container)
    }
}

struct Test: View {
    @Binding var shouldPresent: Bool
    @Binding var shouldComplete: Bool
    let testName: String
    
    var body: some View {
        HStack {
            Button {
                shouldPresent.toggle()
            } label: {
                Text(testName)
            }
            
            Spacer()
            
            if !shouldComplete {
                Image(systemName: "circle")
                    .foregroundStyle(.red)
            } else if shouldComplete {
                Image(systemName: "circle.fill")
                    .foregroundStyle(.green)
            }
        }
    }
}
