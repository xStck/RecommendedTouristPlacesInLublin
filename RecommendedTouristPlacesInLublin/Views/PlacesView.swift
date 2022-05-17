//
//  PlaceView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import CoreData

struct PlacesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var selectedCategoryName: String = ""
    var body: some View {
        VStack{
            Spacer()
            List {
                ForEach(getCategoryByName(viewContext: viewContext, categoryName: selectedCategoryName).placeArray, id: \.id){ place in
                    NavigationLink(destination: PlaceDetailsView(placeDesc: place.desc!, placeName: place.name!, placeLongitude: place.longitude!, placeLatitude: place.latitude!)){
                        HStack{
                            Text(place.name!).multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "star.fill")
                            Text("Ocena: \(String(format: "%.2f", self.calculateRating(place: place)))").multilineTextAlignment(.trailing)
                        }
                    }
                }
            }
            Spacer()
            FooterView()
        }.navigationBarTitle(selectedCategoryName)
    }
    
    func calculateRating(place: Place) -> Double{
        var meanRating: Double = 0.0
        let opinions: [Opinion] = getPlaceByName(viewContext: viewContext, placeName: place.name!).opinionArray
        
        for i in 0..<opinions.count{
            meanRating += Double(opinions[i].rating)
        }
        
        return meanRating/Double(opinions.count)
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView()
    }
}
