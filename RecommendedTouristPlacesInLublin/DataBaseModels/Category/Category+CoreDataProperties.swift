//
//  Category+CoreDataProperties.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var place: NSSet?
    
    public var placeArray: [Place]{
        let set = place as? Set<Place> ?? []
        return set.sorted{
            $0.name! < $1.name!
        }
    }
    
}

// MARK: Generated accessors for place
extension Category {
    
    @objc(addPlaceObject:)
    @NSManaged public func addToPlace(_ value: Place)
    
    @objc(removePlaceObject:)
    @NSManaged public func removeFromPlace(_ value: Place)
    
    @objc(addPlace:)
    @NSManaged public func addToPlace(_ values: NSSet)
    
    @objc(removePlace:)
    @NSManaged public func removeFromPlace(_ values: NSSet)
    
}
