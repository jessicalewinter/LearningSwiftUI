//
//  HeroStore.swift
//  TestSwiftUI
//
//  Created by Jessica Lewinter on 24/06/20.
//

import Foundation

class HeroStore: ObservableObject {
    @Published var heroes: [Hero]
    
    init(heroes: [Hero] = []) {
        self.heroes = heroes
    }
}

let testStore = HeroStore(heroes: testData)
