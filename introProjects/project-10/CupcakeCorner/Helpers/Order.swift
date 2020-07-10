//
//  Order.swift
//  CupcakeCorner
//
//  Created by Jessica Lewinter on 09/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import Foundation

final class Order: ObservableObject {
    static let types: [OrderType] = OrderType.allCases
    @Published var item: OrderItem
    
    enum CodingKeys: CodingKey {
        case item
    }
    
    init() {
        self.item = OrderItem()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        item = try container.decode(OrderItem.self, forKey: .item)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(item, forKey: .item)
    }
}

struct OrderItem: Codable {
    var specialRequest: Bool = false {
        didSet {
            if specialRequest == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var type: Int = 3
    var quantity: Int = 0
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    
    var name: String = ""
    var streetAddress: String = ""
    var city: String = ""
    var zip: String = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            city.trimmingCharacters(in: .whitespaces).isEmpty ||
            zip.trimmingCharacters(in: .whitespaces).isEmpty {
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
}
