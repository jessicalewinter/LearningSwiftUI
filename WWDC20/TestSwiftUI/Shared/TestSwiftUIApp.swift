//
//  TestSwiftUIApp.swift
//  Shared
//
//  Created by Jessica Lewinter on 23/06/20.
//

import SwiftUI

@main
struct TestSwiftUIApp: App {
    @StateObject var store = HeroStore()
    
    var body: some Scene {
        WindowGroup {
            HeroList(store: store)
        }
    }
}

struct TestSwiftUIApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
