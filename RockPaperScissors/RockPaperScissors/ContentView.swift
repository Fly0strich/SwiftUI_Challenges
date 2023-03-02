//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Shae Willes on 8/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var opponentChoice = Int.random(in: 0...2)
    @State private var playerShouldWin = Bool.random()
    @State private var playerWasCorrect = false
    @State private var score = 0
    @State private var currentChance = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let maxQuestions = 10
    
    var choices = ["🪨", "📄", "✂️"]
    
    var body: some View {
            ZStack {
                LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    Spacer()
                    
                    Text("Rock Paper Scissors")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    Spacer()
                    Spacer()
                    
                    ZStack {
                        Color(.black)
                        
                        VStack(alignment: .center, spacing: 20) {
                            Text("Opponent chose \(choices[opponentChoice])")
                                .font(.system(size: 45))
                                .foregroundColor(.white)
                            
                            Text(playerShouldWin ? "Try to win!" : "Try not to win!")
                                .font(.system(size: 30))
                                .foregroundColor(playerShouldWin ? .green : .red)
                            
                            HStack {
                                ForEach(choices, id: \.self) { choice in
                                    Button {
                                        checkAnswer(choice)
                                    } label: {
                                        Text(choice)
                                            .font(.system(size: 100))
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Text("Your score is \(score)")
                        .font(.title.bold())
                    Text("Chance \(currentChance)/10")
                        .font(.headline.bold())
                    
                    Spacer()
                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("New Game", action: newGame)
            } message: {
                Text(alertMessage)
            }
    }
    
    func checkAnswer(_ answer: String) {
        if choices[opponentChoice] == "🪨" {
            if playerShouldWin && answer == "📄" {
                playerWasCorrect = true
            } else if !playerShouldWin && (answer == "🪨" || answer == "✂️") {
                playerWasCorrect = true
            } else {
                playerWasCorrect = false
            }
        } else if choices[opponentChoice] == "📄" {
            if playerShouldWin && answer == "✂️" {
                playerWasCorrect = true
            } else if !playerShouldWin && (answer == "🪨" || answer == "📄") {
                playerWasCorrect = true
            } else {
                playerWasCorrect = false
            }
        } else {
            if playerShouldWin && answer == "🪨" {
                playerWasCorrect = true
            } else if !playerShouldWin && (answer == "📄" || answer == "✂️") {
                playerWasCorrect = true
            } else {
                playerWasCorrect = false
            }
        }
        updateScore(playerWasCorrect)
    }
    
    func updateScore(_ playerWasCorrect: Bool) {
        if playerWasCorrect {
            score += 1
        } else {
            score -= 1
        }
        
        if currentChance < 10 {
            currentChance += 1
            opponentChoice = Int.random(in: 0...2)
            playerShouldWin = Bool.random()
        } else {
            gameOver()
        }
    }
    
    func gameOver() {
        alertTitle = "Game Over"
        alertMessage = "Final Score: \(score)"
        showingAlert = true
    }
    
    func newGame() {
        score = 0
        currentChance = 1
        showingAlert = false
        opponentChoice = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
