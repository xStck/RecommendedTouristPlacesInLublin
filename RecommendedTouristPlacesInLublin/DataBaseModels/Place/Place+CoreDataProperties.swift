//
//  Place+CoreDataProperties.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lattitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var name: String?
    @NSManaged public var category: Category?
    @NSManaged public var opinion: NSSet?

}

// MARK: Generated accessors for opinion
extension Place {

    @objc(addOpinionObject:)
    @NSManaged public func addToOpinion(_ value: Opinion)

    @objc(removeOpinionObject:)
    @NSManaged public func removeFromOpinion(_ value: Opinion)

    @objc(addOpinion:)
    @NSManaged public func addToOpinion(_ values: NSSet)

    @objc(removeOpinion:)
    @NSManaged public func removeFromOpinion(_ values: NSSet)

}
