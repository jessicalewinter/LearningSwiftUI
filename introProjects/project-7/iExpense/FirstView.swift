//
//  FirstView.swift
//  iExpense
//
//  Created by Jessica Lewinter on 30/06/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct FirstView: View {
    @ObservedObject var user = User(firstName: "Bildo", lastName: "Banks")
    @State var showSheet: Bool = false

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            Button("Show sheet") {
                self.showSheet.toggle()
            }
            .sheet(isPresented: $showSheet) {
                SecondView(name: self.user.firstName)
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
