//
//  HeroCell.swift
//  TestSwiftUI
//
//  Created by Jessica Lewinter on 23/06/20.
//

import SwiftUI

struct HeroCell: View {
    var hero: Hero
    
    var body: some View {
        NavigationLink(destination: HeroDetail(hero: hero)) {
            Image(hero.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100.0, height: 100.0)
                .background(Color.black)
                .cornerRadius(15)
            
            VStack(alignment: .leading) {
                Text(hero.name)
                    .font(.headline)
                Text(hero.realName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.padding()
        }
    }
}

struct HeroCell_Previews: PreviewProvider {
    static var previews: some View {
        HeroCell(hero: testData[0])
    }
}
