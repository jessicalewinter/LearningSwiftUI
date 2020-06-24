//
//  HeroCell.swift
//  TestSwiftUI
//
//  Created by Jessica Lewinter on 23/06/20.
//

import SwiftUI

struct HeroCell: View {
    var hero: Hero
    var isHeroOk: Bool = true
    var size: CGFloat = 100.0
    
    var body: some View {
        NavigationLink(destination: HeroDetail(hero: hero)) {
            Image(hero.imageName)
                .resizedToFill(width: size, height: size)
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
