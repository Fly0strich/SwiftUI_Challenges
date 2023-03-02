//
//  ContentView.swift
//  Animultiplication
//
//  Created by Shae Willes on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    @State private var gameStarted = false
    @State private var difficulty = 0
    @State private var numberOfQuestions = 0
    
    var body: some View {
        ZStack {
            if gameStarted {
                GameView(difficulty: difficulty, numberOfQuestions: numberOfQuestions, newGame: newGame)
            }
            
            if !gameStarted {
                SettingsView(startGame: startGame)
            }
        }
    }
    
    func startGame(difficulty: Int, numberOfQuestions: Int) {
        self.difficulty = difficulty
        self.numberOfQuestions = numberOfQuestions
        gameStarted = true
    }
    
    func newGame() {
        gameStarted = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
