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
    @State private var showAddOpinionSheet: Bool = false
    @State var counter: Int = 0
    @State var myAnnotation = MyAnnotation(title: "", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    @State var opinions: [Opinion] = []
    var body: some View {
        VStack(){
            VStack(alignment: .leading){
                Text("\(placeName)").font(.largeTitle).fontWeight(.bold).fixedSize(horizontal: false, vertical: true)
                Spacer()
                VStack(alignment: .leading){
                    Text("OPIS").font(.title).foregroundColor(Color.blue)
                    Text(placeDesc)
                }.onAppear(perform: self.addVariables)
                Spacer()
                VStack(alignment: .leading){
                    Text("LOKALIZACJA").font(.title).foregroundColor(Color.blue)
                    MapCreator(myAnnotation: $myAnnotation).frame(width: UIScreen.main.bounds.size.width, height: CGFloat(200), alignment: .center)
                }.onAppear(perform: self.addOpinions)
                Spacer()
                VStack(alignment: .leading){
                    Text("OPINIE").font(.title).foregroundColor(Color.blue)
                    VStack(alignment: .leading){
                        if(!opinions.isEmpty){
                            Text("Użytkownik: ").fontWeight(.bold)
                            Text("\(opinions[counter].user!.username!)")
                            Text("Ocena: ").fontWeight(.bold)
                            Text("\(opinions[counter].rating)")
                            Text("Opinia:").fontWeight(.bold)
                            Text("\(opinions[counter].content! )")
                        }
                    }.gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local).onEnded({value in
                        if value.translation.width < 0 && self.counter < self.getPlaceByName(viewContext: self.viewContext, placeName: self.placeName).opinionArray.count - 1{
                            self.counter += 1
                        }
                        if value.translation.width > 0 && self.counter >= 1{
                            self.counter -= 1
                        }
                    }))
                    VStack{
                        Button(action: {
                            self.showAddOpinionSheet.toggle()
                        }){
                            Text("Dodaj opinię").buttonCustomStyle()
                        }
                    }.sheet(isPresented: $showAddOpinionSheet){
                        AddOpinionView(placeName: self.placeName).environment(\.managedObjectContext, self.viewContext)
                
                    }
                }
            }
            Spacer()
            FooterView()
        }
    }
    private func addVariables(){
        self.myAnnotation = MyAnnotation(title: placeName, subtitle: "",
                                         coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(placeLatitude)!, longitude: CLLocationDegrees(placeLongitude)!))
    }
    private func addOpinions(){
        self.opinions = getPlaceByName(viewContext: viewContext, placeName: placeName).opinionArray
    }
}

struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailsView()
    }
}
