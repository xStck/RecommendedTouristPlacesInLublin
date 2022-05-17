//
//  PlaceDetailsView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import CoreData
import MapKit

struct PlaceDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var placeDesc: String = ""
    var placeName: String = ""
    var placeLongitude: String = ""
    var placeLatitude: String = ""
    @State var myAnnotation = MyAnnotation(title: "", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    
    var body: some View {
        VStack(){
            Spacer()
            HStack(){
                VStack(){
                    Text("Opis").font(.largeTitle)
                    Text(placeDesc)
                }.onAppear(perform: self.addAnnotation)
                VStack{
                    Text("Lokalizacja").font(.largeTitle).multilineTextAlignment(.leading)
                    MapCreator(myAnnotation: $myAnnotation).frame(width: CGFloat(200), height: CGFloat(200), alignment: .center)
                }
            }
            Spacer()
        }.navigationBarTitle(placeName)
    }
    private func addAnnotation(){
        print(placeLatitude)
        print(placeLongitude)
        self.myAnnotation = MyAnnotation(title: placeName, subtitle: "",
                                         coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(placeLongitude)!, longitude: CLLocationDegrees(placeLatitude)!))
    }
}

struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailsView()
    }
}
