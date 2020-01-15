//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Jessica Lewinter on 14/01/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    
    func largeTitleStyle() -> some View {
        self.modifier(LargeTitle())
    }
}

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Color.blue
        .frame(width: 200, height: 200)
        .watermarked(with: "some animojii")
    }
}

struct ContentView: View {
    @State var changeColor = true
    
    var body: some View {
        VStack {
            Text("Gryffindor")
                .blur(radius: 5)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
                .largeTitleStyle()
            CapsuleText(text: "Hello mama")
        }.blur(radius: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
