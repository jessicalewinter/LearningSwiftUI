//
//  ContentView.swift
//  Shared
//
//  Created by Jessica Lewinter on 25/06/20.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ShareEditDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(ShareEditDocument()))
    }
}
