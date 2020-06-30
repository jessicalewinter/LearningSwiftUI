//
//  ShareEditApp.swift
//  Shared
//
//  Created by Jessica Lewinter on 25/06/20.
//

import SwiftUI

@main
struct ShareEditApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ShareEditDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
