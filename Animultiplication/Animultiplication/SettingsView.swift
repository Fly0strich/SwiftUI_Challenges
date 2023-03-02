//
//  SettingsView.swift
//  Animultiplication
//
//  Created by Shae Willes on 2/28/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var difficulty = 2
    @State private var numberOfQuestions = 5
    
    let startGame: (Int, Int) -> Void
    let numberOfQuestionsOptions = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper("\(difficulty)", value: $difficulty, in: 2...12)
                } header: {
                    Text("Difficulty")
                }
                
                Section {
                    Picker("Number of questions)", selection: $numberOfQuestions) {
                        ForEach(numberOfQuestionsOptions, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Number of Questions")
                }
            }
            .navigationTitle(Text("Settings"))
            .toolbar {
                Button("Start") {
                    startGame(difficulty, numberOfQuestions)
                }
            }
        }
    }
    
    init(startGame: @escaping (Int, Int) -> Void) {
        self.startGame = startGame
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(startGame: {_,_ in })
    }
}
