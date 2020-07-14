//
//  Student+CoreDataProperties.swift
//  Bookworm
//
//  Created by Jessica Lewinter on 13/07/20.
//  Copyright © 2020 Jessica Lewinter. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}
