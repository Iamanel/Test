//
//  User+CoreDataProperties.swift
//  AnelProject2.0
//
//  Created by Sagynzhan Amangeldi on 17.05.2024.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
