//
//  ContentView.swift
//  RockPaperScissorsLizardSpock
//
//  Created by Jessica Lewinter on 16/01/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

enum Status {
    case win
    case lose
    case tie
}

enum Moves: String, CaseIterable {
    case rock
    case paper
    case scissors
    case lizard
    case spock
    
    static var movesArray: [String] {
        var moves = [String]()
        
        for move in Moves.allCases {
            moves.append(move.rawValue)
        }
        
        return moves
    }
}

struct ContentView: View {
    @State var counter = 0
    @State var pcMove = ""
    @State var userMove = ""
    @State var showPCMove = false
    
    let winnerMoves: [(Moves, Moves)] = [
        (.rock, .scissors),
        (.rock, .lizard),
        (.paper, .rock),
        (.paper, .spock),
        (.scissors, .paper),
        (.scissors, .lizard),
        (.lizard, .spock),
        (.lizard, .paper),
        (.spock, .rock),
        (.spock, .scissors)
    ]
    
    func verifyIfWin(userMove: String, pcMove: String) -> String {
        var returnString = "Loser"
        var status = "Bad"
        winnerMoves.forEach { (first, second) in
            if first.rawValue == userMove && second.rawValue == pcMove {
                returnString = "You win :D"
                status = "\(returnString)\n \(userMove) beats \(pcMove)"
            } else if userMove == pcMove {
                status = "Tie! Please play again"
            } else if first.rawValue == pcMove && second.rawValue == userMove {
                returnString = "You lose :("
                status = "\(returnString)\n \(pcMove) beats \(userMove)"
            }
        }
        return status
    }
    
    var body: some View {
        NavigationView {
            VStack( alignment: .leading, spacing: 10 ) {
                
                Section {
                    Text("Choose your move:")
                        .padding([.leading, .top, .bottom], 20)
                    
                    Picker("Picker a number", selection: $counter) {
                        ForEach(0..<Moves.allCases.count) {
                            Text("\(Moves.movesArray[$0].capitalized)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
                                
                Button(action: {
                    print("You started")
                    self.pcMove = Moves.movesArray.randomElement()!
                    self.showPCMove = true
                    self.userMove = Moves.movesArray[self.counter]

                }) {
                    Text("Play!")
                }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.top)
                
                if self.showPCMove {
                    VStack {
                        Text("User move is \(self.userMove)")
                        Text("PC move is \(self.pcMove)")
                        Text("\(verifyIfWin(userMove: self.userMove, pcMove: self.pcMove))")
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("RPSLS")
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
