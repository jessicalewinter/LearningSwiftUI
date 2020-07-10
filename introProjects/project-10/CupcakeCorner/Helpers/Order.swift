//
//  Order.swift
//  CupcakeCorner
//
//  Created by Jessica Lewinter on 09/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import Foundation

final class Order: ObservableObject, Codable {
    static let types: [OrderType] = OrderType.allCases
    
    @Published var specialRequest: Bool = false {
        didSet {
            if specialRequest == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var type: Int = 3
    @Published var quantity: Int = 0
    @Published var extraFrosting: Bool = false
    @Published var addSprinkles: Bool = false
    
    @Published var name: String = ""
    @Published var streetAddress: String = ""
    @Published var city: String = ""
    @Published var zip: String = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var totalPrice: Double = Double(quantity) * 2
        totalPrice += Double(type) / 2
        
        if extraFrosting {
            totalPrice += Double(quantity)
        }
        
        if addSprinkles {
            totalPrice += 0.5 * Double(quantity)
        }
        
        return totalPrice
    }
    
    enum CodingKeys: CodingKey {
        case type
        case quantity
        case extraFrosting
        case addSprinkles
        case name
        case streetAddress
        case city
        case zip
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
}
