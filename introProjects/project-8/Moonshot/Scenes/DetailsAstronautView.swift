//
//  DetailsAstronautView.swift
//  Moonshot
//
//  Created by Jessica Lewinter on 06/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct AstronautMissions {
    let id: Int
    let mission: Mission
}

struct DetailsAstronautView: View {
    let astronaut: Astronaut
    let missions: [AstronautMissions]
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        var matches: [AstronautMissions] = []
        
        for mission in DefaultFiles.missions {
            for member in mission.crew {
                if astronaut.id == member.name {
                    matches.append(AstronautMissions(id: mission.id, mission: mission))
                }
            }
        }
        
        self.missions = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.missions, id: \.id) { astronauts in
                        HStack {
                            Image(astronauts.mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            VStack(alignment: .leading) {
                                Text(astronauts.mission.displayName)
                                    .font(.headline)
                                Text(astronauts.mission.formattedDate)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
        }
    }
}

struct DetailsAstronautView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsAstronautView(astronaut: DefaultFiles.astronauts[0])
    }
}
