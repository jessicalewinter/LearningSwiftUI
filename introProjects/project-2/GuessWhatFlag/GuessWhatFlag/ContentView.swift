//
//  ContentView.swift
//  GuessWhatFlag
//
//  Created by Jessica Lewinter on 14/01/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var showingScore = false
    @State var scoreTitle = ""
    @State var alertMessage = ""
    @State var userPoints = 0
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            userPoints += 1
            alertMessage = "Your score is \(userPoints)"
        } else {
            scoreTitle = "Wrong!"
            alertMessage = "BAAAN. That's actually \(countries[number])"
        }
        showingScore = true
    }
    
    func askAnswer() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of:")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                Text("Score: \(userPoints)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }.alert(isPresented: self.$showingScore) {
                Alert(title: Text(self.scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("OK!"), action: {
                    self.askAnswer()
                }))
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
