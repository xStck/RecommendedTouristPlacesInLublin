//
//  Opinion+CoreDataProperties.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//
//

import Foundation
import CoreData


extension Opinion {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Opinion> {
        return NSFetchRequest<Opinion>(entityName: "Opinion")
    }
    
    @NSManaged public var content: String?
    @NSManaged public var id: UUID?
    @NSManaged public var rating: Int16
    @NSManaged public var place: Place?
    @NSManaged public var user: User?
    
}
