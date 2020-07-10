//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Jessica Lewinter on 09/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.item.name)
                TextField("Street Address", text: $order.item.streetAddress)
                TextField("City", text: $order.item.city)
                TextField("Zip", text: $order.item.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Checkout")
                }
            }.disabled(!order.item.hasValidAddress)
        }
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
