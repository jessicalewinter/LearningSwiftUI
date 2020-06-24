//
//  Hero.swift
//  CuteUI
//
//  Created by Jessica Lewinter on 18/06/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import Foundation

@propertyWrapper
struct TwelveOrLess {
    private var number: Int
    
    init() {
        self.number = 0
    }
    
    var wrappedValue: Int {
        get {
            return number
        }
        set {
            number = min(newValue, 12)
        }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}
