//
//  ContentView.swift
//  WorldScramble
//
//  Created by Jessica Lewinter on 10/03/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI
// MARK:- TODO
// Put a text view below the List so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.

// MARK:- Code

struct ContentView: View {
    @State private var usedWords: [String] = [String]()
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    @State private var score: Int = 0
    
    //Error messages
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    func addNew(word: String) {
        let answer = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            newWord = ""
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word is not recognized", message: "Don't create new words! English plz")
            newWord = ""
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word is not possible", message: "You have to choose a real word")
            newWord = ""
            return
        }
        
        usedWords.insert(answer, at: 0)
        countScore(word: word)
    }
    
    func countScore(word: String) {
        guard word.count >= 3 else { return }
        score += word.count
    }
    
    func startGame() {
        guard let file = Bundle.main.url(forResource: "start", withExtension: "txt") else { fatalError("Could not load start.txt from bundle") }
        do {
            let startWords = try String(contentsOf: file)
            let allWords = startWords.components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "random"
        } catch {
            fatalError("Could not read file")
        }
    }
    
    func isOriginal(word: String) -> Bool {
        guard word != rootWord else {
            return false
        }
        
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        guard word.count >= 3 else {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: {
                    self.addNew(word: self.newWord)
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("\(score)")
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(leading: Button(action: {
                print("Restart Game")
                self.startGame()
            }, label: {
                Text("Start game")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
