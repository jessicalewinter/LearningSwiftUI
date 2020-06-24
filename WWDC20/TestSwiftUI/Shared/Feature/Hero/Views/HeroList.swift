//
//  ContentView.swift
//  Shared
//
//  Created by Jessica Lewinter on 23/06/20.
//

import SwiftUI

struct HeroList: View {
    @ObservedObject var store: HeroStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.heroes) { (hero) in
                    HeroCell(hero: hero)
                }
                .onMove { indecies, newOffset in
                    withAnimation {
                        store.heroes.move(fromOffsets: indecies, toOffset: newOffset)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        store.heroes.remove(atOffsets: indexSet)
                    }
                }
                
                HStack {
                    Spacer()
                    Text("\(store.heroes.count) Heroes")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                
            }
            .navigationTitle("Heroes")
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif
                Button("Add") {
                    withAnimation {
                        store.heroes.append(Hero(name: "Fake hero", realName: "John Doe"))
                    }
                }
            }
            
            Text("Select a hero")
                .font(.largeTitle)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeroList(store: testStore)
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            HeroList(store: testStore)
        }
    }
}
