//
//  ContentView.swift
//  iExpense
//
//  Created by Jessica Lewinter on 30/06/20.
//  Copyright © 2020 Jessica Lewinter. All rights reser   ved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State var showingAdd = false
    @State var color: Color = .black
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            self.style(value: item.amount)
                        }
                    }
                    .onDelete(perform: removeItems(at:))
                }
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingAdd = true
                }) {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $showingAdd) {
                AddView(expenses: self.expenses)
            }
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
    
    func setStyle(color: Color, text: String) -> Text {
        return Text(text).foregroundColor(color)
    }
    
    func style(value: Int) -> Text {
        if value < 10 {
            return setStyle(color: .red, text: "$\(value)")
        } else if value > 10 && value < 100 {
            return setStyle(color: .yellow, text: "$\(value)")
        } else {
            return setStyle(color: .green, text: "$\(value)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
