//
//  GameView.swift
//  Animultiplication
//
//  Created by Shae Willes on 2/28/23.
//

import SwiftUI

struct GameView: View {
    @State private var questions: [String : Int] = [:]
    @State private var currentQuestion = ""
    @State private var correctAnswer = ""
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var questionCounter = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    let difficulty: Int
    let numberOfQuestions: Int
    let newGame: () -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.secondary
                
                VStack {
                    
                    Spacer()
                    
                    Group {
                        HStack {
                            Text(currentQuestion)
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                            
                            Text(userAnswer)
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    Group {
                        ForEach(0..<2) { row in
                            HStack {
                                ForEach (0..<5) { column in
                                    Button("\((row * 5) + column)", action: {
                                        if userAnswer == "?" {
                                            userAnswer = ""
                                        }
                                        userAnswer.append(String((row * 5) + column)) } )
                                    .frame(width: 70, height: 70, alignment: .center)
                                    .background(Color(.white))
                                    .font(.title.bold())
                                    .foregroundColor(.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                        }
                        
                        HStack {
                            Button("Clear", action: { userAnswer = "?"} )
                                .frame(width: 185, height: 70, alignment: .center)
                                .background(Color(.red))
                                .font(.title.bold())
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(5)
                            
                            Button("Submit", action: checkAnswer)
                                .frame(width: 185, height: 70, alignment: .center)
                                .background(Color(.blue))
                                .font(.title.bold())
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(5)
                        }
                        .padding(20)
                    }
                    
                    Spacer()
                    
                    Group {
                        Text("Question \(questionCounter) of \(numberOfQuestions)")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Text("Your score is \(score)")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                }
            }
            .navigationTitle("Animultiplication")
            .toolbar { Button("New Game", action: newGame) }
            .onAppear(perform: generateQuestions)
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("New Game", action: newGame)
            } message: {
                Text(scoreMessage)
            }
        }
    }
    
    init(difficulty: Int, numberOfQuestions: Int, newGame: @escaping () -> Void) {
        self.difficulty = difficulty
        self.numberOfQuestions = numberOfQuestions
        self.newGame = newGame
    }
    
    func generateQuestions() {
        for factorOne in 0...12 {
            for factorTwo in 0...difficulty {
                questions.updateValue(factorOne * factorTwo, forKey: "\(factorOne) x \(factorTwo) = ")
            }
        }
        askQuestion()
    }
    
    func askQuestion() {
        guard let randomQuestion = questions.randomElement() else {
            fatalError("There was a problem loading the questions")
        }
        
        currentQuestion = randomQuestion.key
        correctAnswer = String(randomQuestion.value)
        questionCounter += 1
        userAnswer = "?"
    }
    
    func checkAnswer() {
        if userAnswer == correctAnswer {
            score += 1
        }
        
        if questionCounter < numberOfQuestions {
            askQuestion()
        } else {
            scoreTitle = "GameOver"
            scoreMessage = "Final Score: \(score)"
            showingScore = true
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(difficulty: 12, numberOfQuestions: 10, newGame: {})
    }
}
