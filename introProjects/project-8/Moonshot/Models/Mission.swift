//
//  Mission.swift
//  Moonshot
//
//  Created by Jessica Lewinter on 04/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import UIKit

struct Mission: Codable, Identifiable {
    struct CrewMembers: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewMembers]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var formattedDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}

