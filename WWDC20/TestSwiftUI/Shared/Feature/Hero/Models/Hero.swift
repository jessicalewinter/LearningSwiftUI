//
//  Hero.swift
//  TestSwiftUI
//
//  Created by Jessica Lewinter on 23/06/20.
//

import Foundation

struct Hero: Identifiable {
    var id = UUID()
    var name: String
    var realName: String
    var isAlive: Bool = true
    
    var imageName: String {
        name.lowercased()
    }
    var thumbnail: String {
        "\(name) Thumb"
    }
}

let testData = [
    Hero(name: "Batman", realName: "Bruce Wayne", isAlive: true),
    Hero(name: "Deadpool", realName: "Wade Wilson", isAlive: true),
    Hero(name: "Superman", realName: "Clark Kent", isAlive: true),
    Hero(name: "Aquaman", realName: "Orin", isAlive: true),
    Hero(name: "Spider-Man", realName: "Peter Parker", isAlive: true),
    Hero(name: "Hulk", realName: "Bruce Banner", isAlive: true)
]
