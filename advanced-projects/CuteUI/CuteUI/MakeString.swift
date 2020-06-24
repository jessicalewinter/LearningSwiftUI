//
//  MakeString.swift
//  CuteUI
//
//  Created by Jessica Lewinter on 18/06/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import Foundation

@propertyWrapper
struct MakeString<T> {
    var defaultString: T?
    
    init(defaultString: T) {
        self.defaultString = defaultString
    }
    
    var wrappedValue: T? {
        get {
            return defaultString == nil ? nil : defaultString
        }
        
        set {
            self.defaultString = newValue
        }
    }
}
