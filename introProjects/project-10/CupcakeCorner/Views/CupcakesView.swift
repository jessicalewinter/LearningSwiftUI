//
//  CupcakesView.swift
//  CupcakeCorner
//
//  Created by Jessica Lewinter on 09/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct CupcakesView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $order.item.type, label: Text("Choose your flavour")) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0].rawValue.capitalized)
                        }
                    }
                    
                    Stepper(value: $order.item.quantity, in: 1...20) {
                        Text("Number of cakes: \(order.item.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.item.specialRequest.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.item.specialRequest {
                        Toggle(isOn: $order.item.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.item.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery Details")
                    }
                }
            }
        .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct CupcakesView_Previews: PreviewProvider {
    static var previews: some View {
        CupcakesView()
    }
}
