//
//  HeroDetail.swift
//  TestSwiftUI
//
//  Created by Jessica Lewinter on 23/06/20.
//

import SwiftUI

struct HeroDetail: View {
    var hero: Hero
    @State private var zoomed: Bool = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)

            Image(hero.imageName)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill : .fit)
                .onTapGesture {
                    withAnimation {
                        zoomed.toggle()
                    }
                }
            
            Spacer(minLength: 0)
            
            if hero.isAlive && !zoomed {
                HStack {
                    Spacer()
                    Image(systemName:"person.fill")
                    Text("Alive")
                    Spacer()
                }
                .padding(.all)
                .font(Font.headline.smallCaps())
                .background(Color.green)
                .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle(hero.name)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HeroDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HeroDetail(hero: testData[0])
        }
    }
}
