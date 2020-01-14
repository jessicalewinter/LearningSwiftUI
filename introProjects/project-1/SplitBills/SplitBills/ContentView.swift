//
//  ContentView.swift
//  SplitBills
//
//  Created by Jessica Lewinter on 14/01/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let totalAmount = Double(checkAmount) ?? 0
        let people = Double((Int(numberOfPeople) ?? 0) + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let perPerson = totalAmount/people
        let withTip = perPerson * 0.01 * tipSelection + perPerson
        return withTip
    }
    
    var totalAmount: Double {
        let totalAmount = Double(checkAmount) ?? 0
        let tipsSelection = Double(tipPercentages[tipPercentage])
        let withTip = totalAmount * (1 + tipsSelection * 0.01)
        return withTip
    }
    
        
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Amount")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Number of People")) {
                    TextField("Number of People", text: $numberOfPeople)
                    .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount Per Person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total Amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Split Bills")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
