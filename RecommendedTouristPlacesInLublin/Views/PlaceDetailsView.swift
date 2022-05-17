//
//  PlaceDetailsView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import CoreData

struct PlaceDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var placeDesc: String = ""
    var placeName: String = ""
    var placeLongitude: String = ""
    var placeLattitude: String = ""
    var body: some View {
        VStack(){
            Text("\(placeName)\n\(placeDesc)\n\(placeLongitude)\n\(placeLattitude)\n")
        }
    }
    
    func getPlaceByName(placeName: String) -> Place{
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
}

struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailsView()
    }
}
