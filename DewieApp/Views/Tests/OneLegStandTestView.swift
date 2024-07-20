//
//  OneLegStandTestView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/28/24.
//

import SwiftUI

struct OneLegStandTestView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var currentOfficer: Officer
    let caseNumber: String
    let dateTime: String
    
    @State var putsFootDown: Bool = false
    @State var sways: Bool = false
    @State var raisesArmsForBalance: Bool = false
    @State var hops: Bool = false
    
    @State var oneLegStandNotes: String = ""
    
    @State var submitOneLegStand: Bool = false
    @Binding var oneLegStandTestComplete: Bool
    @Binding var oneLegStandTestResults: Report.OneLegStand?
    
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
                .foregroundColor(.white)
                .padding(25)
            }
            .frame(height: 75)
            
            TabView {
                OneLegStandInstructionTab()
                
                OneLegStandResultsTab(putsFootDown: $putsFootDown, sways: $sways, raisesArmsForBalance: $raisesArmsForBalance, hops: $hops)
                
                OneLegStandNotesTab(oneLegStandNotes: $oneLegStandNotes, submitOneLegStand: $submitOneLegStand)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .background(.black)
        }
        .onChange(of: submitOneLegStand) {
            print(oneLegStandNotes)
            oneLegStandTestResults = Report.OneLegStand(putsFootDown: putsFootDown, sways: sways, raisesArmsForBalance: raisesArmsForBalance, hops: hops, oneLegStandNotes: oneLegStandNotes)
            oneLegStandTestComplete = true
            dismiss()
        }
    }
}
struct OneLegStandInstructionTab: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("One Leg Stand Instruction")
                .padding(.vertical)
                .font(.largeTitle)
                .bold()
                .textScale(.secondary)
            
            Divider()
                .frame(height: 2)
                .overlay(.black)
            ScrollView {
                VStack(alignment: .leading) {
                    Text("1. Stand with your feet together and your arms at your side. Maintain this position until told otherwise.")
                        .padding(.vertical, 25)
                    Text("2. When I tell you to, I want you to raise one leg (either leg) approximately six inches off the ground, keeping the raised foot parallel to the ground, both legs straight, and with both arms at your side.")
                        .padding(.vertical, 25)
                    Text("3. Look at the elevated foot and count out loud in the following manner \"1001, 1002, 1003\" and so on, until told to stop. (Demonstrate)")
                        .padding(.vertical, 25)
                    Text("4. Do you understand the instructions?")
                        .padding(.vertical, 25)
                    Text("5. Begin")
                        .padding(.vertical, 25)
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

struct OneLegStandResultsTab: View {
    @Binding var putsFootDown: Bool
    @Binding var sways: Bool
    @Binding var raisesArmsForBalance: Bool
    @Binding var hops: Bool
    
    var body: some View {
        VStack {
            Text("One Leg Stand - Scoring")
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
                    Toggle("Puts Foot Down", isOn: $putsFootDown)
                    Toggle("Sways", isOn: $sways)
                    Toggle("Raises Arm(s) for Balance", isOn: $raisesArmsForBalance)
                    Toggle("Hops", isOn: $hops)
                } header: {
                    Text("Performance Phase")
                }
                
                CountdownTimer()
            }
            //Timer Section
            .frame(height: 550)
        }
    }
}

struct OneLegStandNotesTab: View {
    @Binding var oneLegStandNotes: String
    @Binding var submitOneLegStand: Bool
    
    var body: some View {
        VStack {
            Text("One Leg Stand - Observations")
                .padding(.top, 50)
            
            TextEditor(text: $oneLegStandNotes)
                .scrollContentBackground(.hidden)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 7.0))
                .padding()
                .foregroundStyle(.black)
            
            Button {
                submitOneLegStand = true
            } label: {
                Text("Submit One Leg Stand Results")
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

struct CountdownTimer: View {
    @State var timeRemaining = 30
    @State var timerStarted = false
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Tap to start timer")
            HStack {
                Spacer()
                Button {
                    if !timerStarted {
                        timerStarted.toggle()
                    } else {
                        timeRemaining = 30
                        timerStarted.toggle()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .tint(timerStarted ? .red : .dewieGreen)
                        Text("\(timeRemaining)")
                            .onReceive(timer, perform: { _ in
                                if timerStarted {
                                    if timeRemaining > 0 {
                                        timeRemaining -= 1
                                    }
                                }
                            })
                            .tint(.white)
                            .font(.largeTitle)
                    }
                }
                .frame(width: 150)
                Spacer()
            }
            Text("Tap again to reset timer")
        }
    }
    
}


#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        
        return OneLegStandTestView(currentOfficer: .constant(.previewOfficerData), caseNumber: "24-1111", dateTime: Date().formatted(date: .abbreviated, time: .shortened), oneLegStandTestComplete: .constant(false), oneLegStandTestResults: .constant(nil))
            .modelContainer(container)
    }
}
