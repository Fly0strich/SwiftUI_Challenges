//
//  DiceRoller.swift
//  HighRoller
//
//  Created by Shae Willes on 10/2/22.
//

import Foundation

class DiceRoller: ObservableObject {
    enum DieType: Int, CaseIterable, Identifiable {
        case d4 = 4
        case d6 = 6
        case d8 = 8
        case d10 = 10
        case d12 = 12
        case d20 = 20
        case d100 = 100
        
        var id: RawValue {
            self.rawValue
        }
        
        func roll() -> Int {
            Int.random(in: 1...self.rawValue)
        }
    }
    
    private var dice: [DieType] {
        var selectedDice = [DieType]()
        for dieType in DieType.allCases {
            var amountToCreate = diceQuantities[dieType] ?? 0
            while amountToCreate > 0 {
                selectedDice.append(dieType)
                amountToCreate -= 1
            }
        }
        return selectedDice
    }
    
    @Published var diceQuantities: [DieType: Int]
    
    init() {
        diceQuantities = [.d4: 0, .d6: 0, .d8: 0, .d10: 0, .d12: 0, .d20: 0, .d100: 0]
    }
    
    func rollDice() -> [Int] {
        dice.map( { $0.roll() } )
    }
}
