//
//  databaseFunctions.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import CoreData

extension View {
    
    func getPlaceByName(viewContext: NSManagedObjectContext, placeName: String) -> Place{
         var aPlace: Place?
         do{
             let placeFetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
             placeFetchRequest.predicate = NSPredicate(format: "name == %@", placeName)
             let fetchedResults = try viewContext.fetch(placeFetchRequest)
             aPlace = fetchedResults.first!
         }catch{
             print("fetch task failed", error)
         }
         return aPlace!
     }
    
    func getCategoryByName(viewContext: NSManagedObjectContext, categoryName: String) -> Category{
         var aCategory: Category?
         do{
             let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
             categoryFetchRequest.predicate = NSPredicate(format: "name == %@", categoryName)
             let fetchedResults = try viewContext.fetch(categoryFetchRequest)
             aCategory = fetchedResults.first!
         }catch{
             print("fetch task failed", error)
         }

         return aCategory!
     }
    
    func getUserByUserName(viewContext: NSManagedObjectContext, userName: String) -> User?{
         var aUser: User?
         do{
             let userFetchRequest: NSFetchRequest<User> = User.fetchRequest()
             userFetchRequest.predicate = NSPredicate(format: "username == %@", userName)
             let fetchedResults = try viewContext.fetch(userFetchRequest)
             aUser = fetchedResults.first
         }catch{
             print("fetch task failed", error)
         }

         return aUser
     }
    
}
