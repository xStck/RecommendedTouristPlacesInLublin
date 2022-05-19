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
    @Binding var userUserName: String
    @State private var showAddOpinionSheet: Bool = false
    @State private var counter: Int = 0
    @State private var changeDayNight: Bool = false
    @State private var myAnnotation = MyAnnotation(title: "", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    @State private var opinions: [Opinion] = []
    var body: some View {
        VStack(){
            
            Toggle(isOn: $changeDayNight){
                if(changeDayNight == false){
                    Text("Zmień na tryb nocny").dayNightStyleText(toggle: changeDayNight)
                }else{
                    Text("Zmień na tryb dzienny").dayNightStyleText(toggle: changeDayNight)
                }
            }
            
            VStack(alignment: .leading){
                
                Text("\(placeName)").font(.largeTitle).fontWeight(.bold).fixedSize(horizontal: false, vertical: true).dayNightStyleText(toggle: changeDayNight)
                
                Spacer()
                
                VStack(alignment: .leading){
                    Text("OPIS").font(.title).foregroundColor(Color.blue)
                    Text(placeDesc).dayNightStyleText(toggle: changeDayNight)
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
                            Text("Użytkownik: ").fontWeight(.bold).dayNightStyleText(toggle: changeDayNight)
                            Text("\(opinions[counter].user!.username!)").dayNightStyleText(toggle: changeDayNight)
                            Text("Ocena: ").fontWeight(.bold).dayNightStyleText(toggle: changeDayNight)
                            Text("\(opinions[counter].rating)").dayNightStyleText(toggle: changeDayNight)
                            if(!opinions[counter].content!.trimmingCharacters(in: .whitespaces).isEmpty){
                                Text("Opinia:").fontWeight(.bold).dayNightStyleText(toggle: changeDayNight)
                                Text("\(opinions[counter].content! )").dayNightStyleText(toggle: changeDayNight)
                            }
                        }
                    }.gesture(DragGesture(minimumDistance: 5, coordinateSpace: .local).onEnded({value in
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
                        AddOpinionView(placeName: self.placeName, userUserName: self.userUserName, opinions: self.$opinions).environment(\.managedObjectContext, self.viewContext)
                    }
                    
                }
            }
            Spacer()
            FooterView()
        }.dayNightStyleBackground(toggle: changeDayNight)
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
        PlaceDetailsView(userUserName: .constant(""))
    }
}
