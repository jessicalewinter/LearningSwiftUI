//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Jessica Lewinter on 09/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage: String = ""
    @State private var showingConfirmation: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Your total cost is \(self.order.item.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }.padding()
                }
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        
    }
    
    func placeOrder() {
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {return}
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.post.rawValue
        
        do {
            let encoder = JSONEncoder()
            let encode = try encoder.encode(order.item)
            request.httpBody = encode
        } catch {
            print("Could not encode order data")
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error fecthing data: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(OrderItem.self, from: data)
                self.confirmationMessage = "Your order for \(decoded.quantity) x \(Order.types[decoded.type].rawValue) cupcakes is on its way!"
                self.showingConfirmation = true
            } catch {
                print("Invalid response from server")
            }
        }
        dataTask.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
