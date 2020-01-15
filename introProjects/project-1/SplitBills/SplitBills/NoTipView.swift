//
//  NoTipView.swift
//  SplitBills
//
//  Created by Jessica Lewinter on 15/01/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct NotTipView: ViewModifier {
    var text: String
    var value: Int
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
            Text(text)
                .foregroundColor(value == 0 ? .red : .black)
        }
    }
}

extension View {
    func noTipStyle(with text: String, and value: Int) -> some View {
        self.modifier(NotTipView(text: text, value: value))
    }
}
