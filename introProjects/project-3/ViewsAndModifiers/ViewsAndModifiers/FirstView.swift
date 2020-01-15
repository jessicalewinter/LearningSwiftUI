//
//  FirstView.swift
//  ViewsAndModifiers
//
//  Created by Jessica Lewinter on 15/01/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { (row, col) in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row)-C\(col)")
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
