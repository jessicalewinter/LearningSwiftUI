//
//  ContentView.swift
//  Moonshot
//
//  Created by Jessica Lewinter on 02/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct Person: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

enum JSONFiles {
    case astronauts
    case missions
    
    var path: String {
        switch self {
        case .astronauts:
            return "astronauts.json"
        case .missions:
            return "missions.json"
        }
    }
}

struct ContentView: View {
    let astronauts: [Astronaut] = try! Bundle.main.decode(JSONFiles.astronauts.path)
    let missions: [Mission] = try! Bundle.main.decode(JSONFiles.missions.path)
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: DetailMissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedDate)
                    }
                }
            }
        .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
