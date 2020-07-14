//
//  Book+CoreDataProperties.swift
//  Bookworm
//
//  Created by Jessica Lewinter on 14/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var genre: String?
    @NSManaged public var review: String?
    @NSManaged public var rating: Int16

}
