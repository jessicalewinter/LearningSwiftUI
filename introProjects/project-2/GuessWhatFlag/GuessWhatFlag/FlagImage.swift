//
//  FlagImage.swift
//  GuessWhatFlag
//
//  Created by Jessica Lewinter on 15/01/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct FlagImage: ViewModifier {
    var name: String
    
    func body(content: Content) -> some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

extension View {
    func flagImageStyled(of name: String) -> some View {
        self.modifier(FlagImage(name: name))
    }
}
