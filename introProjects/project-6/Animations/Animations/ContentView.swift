//
//  ContentView.swift
//  Animations
//
//  Created by Jessica Lewinter on 11/03/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button(action: {
            print("You tapped me!")
        }) {
            Text("Tap here :D")
        }
        .padding(50)
        .background(Color.yellow)
        .foregroundColor(.black)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.yellow)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: false)
            )
        )
        .onAppear {
            self.animationAmount = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
