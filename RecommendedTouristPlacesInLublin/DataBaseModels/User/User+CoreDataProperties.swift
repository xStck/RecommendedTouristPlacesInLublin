//
//  User+CoreDataProperties.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var username: String?
    @NSManaged public var opinion: NSSet?

}

// MARK: Generated accessors for opinion
extension User {

    @objc(addOpinionObject:)
    @NSManaged public func addToOpinion(_ value: Opinion)

    @objc(removeOpinionObject:)
    @NSManaged public func removeFromOpinion(_ value: Opinion)

    @objc(addOpinion:)
    @NSManaged public func addToOpinion(_ values: NSSet)

    @objc(removeOpinion:)
    @NSManaged public func removeFromOpinion(_ values: NSSet)

}
