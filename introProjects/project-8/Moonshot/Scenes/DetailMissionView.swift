//
//  DetailMissionView.swift
//  Moonshot
//
//  Created by Jessica Lewinter on 06/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
  
struct DetailMissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches: [CrewMember] = []
        
        for member in mission.crew {
            if let match = astronauts.first(where: {$0.id == member.name}) {
                matches.append(CrewMember(role: member.role , astronaut: match))
            } else {
                print("Missing \(member)")
            }
        
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Image(self.mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.5)
                        .padding(.top)
                    
                    Text(self.mission.displayName)
                        .font(.title)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(self.mission.description)
                            .font(.body)
                    }
                    .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: DetailsAstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
            .navigationBarTitle(Text(self.mission.displayName), displayMode: .inline)
        }
    }
}

struct DetailMissionView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = try! Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = try! Bundle.main.decode("missions.json")
    
    static var previews: some View {
        DetailMissionView(mission: missions[0], astronauts: astronauts)
    }
}
