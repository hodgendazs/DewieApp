//
//  HGNTestView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/28/24.
//

import SwiftUI

struct HGNTestView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var currentOfficer: Officer
    let caseNumber: String
    let dateTime: String
    
    @State var equalPupilSize: Bool = false
    @State var noRestingNystagmus: Bool = false
    @State var equalTracking: Bool = false
    
    @State var lackLeftEye: Bool = false
    @State var lackRightEye: Bool = false
    
    @State var distinctLeftEye: Bool = false
    @State var distinctRightEye: Bool = false
    
    @State var onsetLeftEye: Bool = false
    @State var onsetRightEye: Bool = false
    
    @State var vgnPresent: Bool = false
    @State var vgnNotPresent: Bool = true
    
    @State var hgnNotes: String = ""
    
    @State var submitHGN: Bool = false
    @Binding var hgnTestComplete: Bool
    @Binding var hgnTestResults: Report.HGN?
    
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
                // first page
                HGNInstructionTab()
                
                // second page
                HGNTestResultsTab(equalPupilSize: $equalPupilSize, noRestingNystagmus: $noRestingNystagmus, equalTracking: $equalTracking, lackLeftEye: $lackLeftEye, lackRightEye: $lackRightEye, distinctLeftEye: $distinctLeftEye, distinctRightEye: $distinctRightEye, onsetLeftEye: $onsetLeftEye, onsetRightEye: $onsetRightEye, vgnPresent: $vgnPresent)
                
                HGNNotesTab(hgnNotes: $hgnNotes, submitHGN: $submitHGN)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .background(.black)
        }
        .onChange(of: submitHGN) {
            hgnTestResults = Report.HGN(equalPupilSize: equalPupilSize, noRestingNystagmus: noRestingNystagmus, equalTracking: equalTracking, lackLeftEye: lackLeftEye, lackRightEye: lackRightEye, distinctLeftEye: distinctLeftEye, distinctRightEye: distinctRightEye, onsetLeftEye: onsetLeftEye, onsetRightEye: onsetRightEye, vgnNotPresent: vgnNotPresent, vgnPresent: vgnPresent, hgnNotes: hgnNotes)
            hgnTestComplete = true
            dismiss()
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = singleOfficerPreviewContainer.mainContext.container
        let currentOfficer = Officer.previewOfficer
        
        return HGNTestView(currentOfficer: .constant(currentOfficer), caseNumber: "24-1234", dateTime: Date().formatted(date: .abbreviated, time: .shortened), vgnPresent: false, hgnTestComplete: .constant(false), hgnTestResults: .constant(nil))
            .modelContainer(container)
    }
}

struct HGNInstructionTab: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("HGN Instruction")
                .padding(.vertical)
                .font(.largeTitle)
                .bold()
                .textScale(.secondary)
            
            Divider()
                .frame(height: 2)
                .overlay(.black)
            
            VStack(alignment: .leading) {
                Text("1. Put your feet together and your hands at your side.")
                    .padding(.top, 30)
                    .padding(.vertical, 5)
                Text("2. Keep your head still, look at and follow the stimulus with your eyes only.")
                    .padding(.vertical, 5)
                Text("3. Keep looking at the stimulus until the test is over.")
                    .padding(.vertical, 5)
                Text("4. Do you understand the instructions?")
            }
            .font(.title)
            .padding(.horizontal)
            
            Spacer()
        }
        .foregroundStyle(.white)
        .padding()
    }
}

struct HGNTestResultsTab: View {
    @Binding var equalPupilSize: Bool
    @Binding var noRestingNystagmus: Bool
    @Binding var equalTracking: Bool
    
    @Binding var lackLeftEye: Bool
    @Binding var lackRightEye: Bool
    
    @Binding var distinctLeftEye: Bool
    @Binding var distinctRightEye: Bool
    
    @Binding var onsetLeftEye: Bool
    @Binding var onsetRightEye: Bool
    
    @Binding var vgnPresent: Bool
    @State var vgnNotPresent: Bool = true
    
    var body: some View {
        VStack {
            Form {
                // first section
                Section {
                    // toggle section
                    Toggle("Equal Pupil Size", isOn: $equalPupilSize)
                    Toggle("No Resting Nystagmus", isOn: $noRestingNystagmus)
                    Toggle("Equal Tracking", isOn: $equalTracking)
                } header: {
                    Text("HGN / VGN")
                        .padding(.top, 25)
                }
                // second section
                Section {
                    // lack of text
                    HStack {
                        // left eye toggle
                        Toggle("Left Eye", isOn: $lackLeftEye)
                        // right eye toggle
                        Toggle("Right Eye", isOn: $lackRightEye)
                    }
                } header: {
                    Text("Lack of Smooth Pursuit (2 passes each)")
                }
                // third section
                Section {
                    HStack {
                        // left eye toggle
                        Toggle("Left Eye", isOn: $distinctLeftEye)
                        // right eye toggle
                        Toggle("Right Eye", isOn: $distinctRightEye)
                    }
                } header: {
                    Text("Distinct and Sustained Nystagmus at maximum deviation (2 passes each)")
                }
                
                Section {
                    HStack {
                        // left eye toggle
                        Toggle("Left Eye", isOn: $onsetLeftEye)
                        // right eye toggle
                        Toggle("Right Eye", isOn: $onsetRightEye)
                    }
                } header: {
                    Text("ONSET OF NYSTAGMUS PRIOR TO 45° (2 passes each)")
                }
                
                Section {
                    HStack {
                        Toggle("VGN Not Present", isOn: $vgnNotPresent)
                            .onChange(of: vgnNotPresent) {
                                vgnPresent = !vgnNotPresent
                            }
                        Toggle("VGN Present", isOn: $vgnPresent)
                            .onChange(of: vgnPresent) {
                                vgnNotPresent = !vgnPresent
                            }
                    }
                }
            }
        }
    }
}

struct HGNNotesTab: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var hgnNotes: String
    @Binding var submitHGN: Bool
    
    var body: some View {
        VStack {
            Text("HGN / VGN - Observations")
                .padding(.top, 50)
            
            TextEditor(text: $hgnNotes)
                .scrollContentBackground(.hidden)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 7.0))
                .padding()
                .foregroundStyle(.black)
                
            
            Button {
                submitHGN = true
            } label: {
                Text("Submit HGN Results")
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
