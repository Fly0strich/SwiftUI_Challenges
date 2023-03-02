//
//  DiceSelectionView.swift
//  HighRoller
//
//  Created by Shae Willes on 10/2/22.
//

import SwiftUI

struct DiceSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var diceRoller: DiceRoller
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(DiceRoller.DieType.allCases) {
                    Picker("D\($0.rawValue)", selection: $diceRoller.diceQuantities[$0]) {
                        ForEach(0..<101) {
                            Text("\($0)").tag($0 as Int?)
                        }
                    }
                }
            }
            .navigationTitle("Dice Quantities")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

struct DiceSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DiceSelectionView(diceRoller: DiceRoller())
    }
}
