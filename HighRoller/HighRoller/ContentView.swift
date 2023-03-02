//
//  ContentView.swift
//  HighRoller
//
//  Created by Shae Willes on 10/2/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var diceRoller = DiceRoller()
    @State private var rollResults = [Int]()
    @State private var showingDiceSelector = false
    
    let columns = [GridItem(), GridItem(), GridItem(), GridItem(), GridItem(), GridItem()]
    
    var total: Int {
        var sum = 0
        for value in rollResults {
            sum += value
        }
        return sum
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    ForEach(DiceRoller.DieType.allCases) { dieType in
                        if let selectedAmount = diceRoller.diceQuantities[dieType] {
                            if selectedAmount > 0 {
                                LazyVGrid(columns: columns, alignment: .center, spacing: 5) {
                                    ForEach(0..<selectedAmount, id: \.self) { dieIndex in
                                        ZStack {
                                            Rectangle()
                                                .strokeBorder(.black, lineWidth: 1)
                                                .frame(width: 50, height: 50)
                                            
                                            if total > 0 {
                                                Text("\(rollResults[dieIndex + rollResultIndexOffset(for: dieType)])")
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                                Text("D\(dieType.rawValue) x \(selectedAmount)")
                                    .font(.headline.bold())
                                    .padding(.bottom)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                Text("Total: \(total)")
                    .font(.title)
                
                Button("Roll Dice") {
                    rollResults = diceRoller.rollDice()
                }
                .font(.title.bold())
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay(RoundedRectangle(cornerRadius: 5).strokeBorder(.black, lineWidth: 1))
            }
            .navigationTitle("Selected Dice")
            .toolbar {
                Button {
                    showingDiceSelector = true
                } label: {
                    Image(systemName: "dice")
                }
            }
        }
        .sheet(isPresented: $showingDiceSelector) {
            DiceSelectionView(diceRoller: diceRoller)
        }
    }
    
    func rollResultIndexOffset(for dieType: DiceRoller.DieType) -> Int {
        switch dieType {
        case .d4:
            return 0
        case .d6:
            return diceRoller.diceQuantities[.d4]!
        case .d8:
            return diceRoller.diceQuantities[.d4]! + diceRoller.diceQuantities[.d6]!
        case .d10:
            return diceRoller.diceQuantities[.d4]! + diceRoller.diceQuantities[.d6]! + diceRoller.diceQuantities[.d8]!
        case .d12:
            return diceRoller.diceQuantities[.d4]! + diceRoller.diceQuantities[.d6]! + diceRoller.diceQuantities[.d8]! + diceRoller.diceQuantities[.d10]!
        case .d20:
            return diceRoller.diceQuantities[.d4]! + diceRoller.diceQuantities[.d6]! + diceRoller.diceQuantities[.d8]! + diceRoller.diceQuantities[.d10]! + diceRoller.diceQuantities[.d12]!
        case .d100:
            return diceRoller.diceQuantities[.d4]! + diceRoller.diceQuantities[.d6]! + diceRoller.diceQuantities[.d8]! + diceRoller.diceQuantities[.d10]! + diceRoller.diceQuantities[.d12]! + diceRoller.diceQuantities[.d20]!
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
