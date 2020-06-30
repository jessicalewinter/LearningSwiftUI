//
//  User.swift
//  iExpense
//
//  Created by Jessica Lewinter on 30/06/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import Foundation

class User: Codable, ObservableObject {
    @Published var firstName: String = "Bilbo"
    @Published var lastName: String = "Baggins"
    
    enum CodingKeys: CodingKey{
        case firstName
        case lastName
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
    }
}
