//
//  ContentView.swift
//  Moonshot
//
//  Created by Jessica Lewinter on 02/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

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

struct DefaultFiles {
    static let astronauts: [Astronaut] = try! Bundle.main.decode(JSONFiles.astronauts.path)
    static let missions: [Mission] = try! Bundle.main.decode(JSONFiles.missions.path)
}

struct ContentView: View {
    @State var toggleDate: Bool = false
    
    var body: some View {
        NavigationView {
            List(DefaultFiles.missions) { mission in
                NavigationLink(destination: DetailMissionView(mission: mission, astronauts: DefaultFiles.astronauts)) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.toggleDate {
                            withAnimation {
                                Text(self.createFormattedString(crews: mission.crew))
                            }
                        } else {
                            withAnimation {
                                Text(mission.formattedDate)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.toggleDate.toggle()
                }, label: {
                    self.toggleDate ? Text("Show Launch Date") : Text("Show crew")
                }))
        }
    }
    
    func createFormattedString(crews: [Mission.CrewMembers]) -> String {
        var joinedString = ""
        for crew in crews {
            joinedString.append("\(crew.name.capitalized), ")
        }
        return joinedString
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
