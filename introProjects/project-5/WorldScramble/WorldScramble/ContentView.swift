//
//  ContentView.swift
//  WorldScramble
//
//  Created by Jessica Lewinter on 10/03/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = [String]()
    @State private var rootWord: String = "kkk"
    @State private var newWord: String = ""
    
    //Error messages
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    func addNew(word: String) {
        let answer = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word is not recognized", message: "Don't create new words! English plz")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word is not possible", message: "You have to choose a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
        print(usedWords)
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
        !usedWords.contains(word)
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
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
