//
//  PlaceView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import CoreData

struct PlaceView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)])
    private var categories: FetchedResults<Category>
    
    @FetchRequest(entity: Opinion.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Opinion.rating, ascending: true)])
    private var opinions: FetchedResults<Opinion>
    
    var selectedCategoryName: String = ""
    @State var totalRating: Double = 0.0
    var body: some View {
        VStack{
            Spacer()
            List {
                ForEach(getCategoryByName(categoryName: selectedCategoryName).placeArray, id: \.id){ place in
                    HStack{
                        Text(place.name!).multilineTextAlignment(.leading)
                        Spacer()
                        Text("Ocena: \(String(format: "%.2f", self.calculateRating(place: place)))").multilineTextAlignment(.trailing)
                    }
                }
            }
            Spacer()
            FooterView()
        }.navigationBarTitle(selectedCategoryName)
    }
    
    func calculateRating(place: Place) -> Double{
        var meanRating: Double = 0.0
        let opinions: [Opinion] = getPlaceByName(placeName: place.name!).opinionArray
        
        for i in 0..<opinions.count{
            meanRating += Double(opinions[i].rating)
        }
        
        return meanRating/Double(opinions.count)
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
    
    func getCategoryByName(categoryName: String) -> Category{
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
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView()
    }
}
