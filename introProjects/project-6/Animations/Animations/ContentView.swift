//
//  ContentView.swift
//  Animations
//
//  Created by Jessica Lewinter on 11/03/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled: Bool = false
    @State private var dragAmountText: CGSize = .zero
    @State private var dragAmountSquare: CGSize = .zero
    let letters = Array("Hello swift")
    
    
    
    var body: some View {
        let colors = enabled ? [Color.red, Color.yellow] : [Color.yellow, Color.red]
        
        return NavigationView {
            VStack {
                HStack {
                    ForEach(0..<letters.count) {
                        Text(String(self.letters[$0]))
                            .padding(5)
                            .font(.title)
                            .background(self.enabled ? Color.yellow : Color.red)
                            .offset(self.dragAmountText)
                            .animation(Animation.default.delay(Double($0)/20))
                            .gesture(
                                DragGesture()
                                    .onChanged {
                                        self.dragAmountText = $0.translation
                                    }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            self.dragAmountText = .zero
                                            self.enabled.toggle()
                                        }
                                    }
                            )
                    }
                }
                
                
                
                Button(action: {
                    print("hello")
                }) {
                    HStack {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text("Delete")
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.darkGreen, .lightGreen]), startPoint: .leading, endPoint: .trailing ))
                    .cornerRadius(10)
                }
                
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomLeading)
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(dragAmountSquare)
                    .gesture(
                        DragGesture()
                            .onChanged({ (dragValue) in
                                self.dragAmountSquare = dragValue.translation
                            })
                            .onEnded({ (_) in
                                withAnimation(.spring()) {
                                    self.dragAmountSquare = .zero
                                    self.enabled.toggle()
                                }
                            })
                )
            }
//            .navigationBarTitle("Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
