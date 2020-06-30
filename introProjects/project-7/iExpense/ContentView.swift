//
//  ContentView.swift
//  iExpense
//
//  Created by Jessica Lewinter on 30/06/20.
//  Copyright © 2020 Jessica Lewinter. All rights reser   ved.
//

import SwiftUI

struct ContentView: View {
    @State var numbers: [Int] = []
    @State var currentNumber = UserDefaults.standard.integer(forKey: "Tap")
    @State var user: User = User(firstName: "Lore", lastName: "Lee")
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows(at:))
                }
                Button("Add number && Save Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                    
                    let encoder = JSONEncoder()
                    guard let data = try? encoder.encode(self.user) else { return }
                    
                    UserDefaults.standard.set(self.currentNumber, forKey: "Tap")
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
