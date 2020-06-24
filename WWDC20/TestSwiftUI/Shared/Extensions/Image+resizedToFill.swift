//
//  Image+resizedToFill.swift
//  iOS
//
//  Created by Jessica Lewinter on 24/06/20.
//

import SwiftUI

extension Image {
    func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
}
