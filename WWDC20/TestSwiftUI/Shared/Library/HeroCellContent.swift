//
//  HeroCellContent.swift
//  iOS
//
//  Created by Jessica Lewinter on 24/06/20.
//

import Foundation
import SwiftUI

struct HeroCellContent: LibraryContentProvider {
    var hero: Hero
    var size: CGFloat
    
    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(
            HeroCell(hero: hero),
            title: "Hero Cell",
            category: .control
        )
        
        LibraryItem(
            HeroCell(hero: hero, isHeroOk: false),
            title: "Hero Cell With Health Status",
            category: .control
        )
    }
    
    @LibraryContentBuilder
    func modifiers(base: Image) -> [LibraryItem] {
        LibraryItem(
            base.resizedToFill(width: size, height: size)
        )
    }
}
