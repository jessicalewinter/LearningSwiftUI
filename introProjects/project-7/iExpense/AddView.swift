//
//  AddView.swift
//  iExpense
//
//  Created by Jessica Lewinter on 01/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

enum ItemType: String {
    case business = "Business"
    case personal = "Personal"
}

struct AddView: View {
    static let types: [ItemType] = [.business, .personal]
    
    @State private var name = ""
    @State private var type: ItemType = .personal
    @State private var amount = ""
    
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                TextField("Amount", text: $amount).keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let getAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type.rawValue, amount: getAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showAlert.toggle()
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Field"), message:  Text("The amount field is not a number"), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
