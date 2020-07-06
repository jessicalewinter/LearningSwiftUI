//
//  DetailsAstronautView.swift
//  Moonshot
//
//  Created by Jessica Lewinter on 06/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct DetailsAstronautView: View {
    let astronaut: Astronaut
    
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
                }
            }
            .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
        }
    }
}

struct DetailsAstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = try! Bundle.main.decode(JSONFiles.astronauts.path)
    
    static var previews: some View {
        DetailsAstronautView(astronaut: astronauts[0])
    }
}
