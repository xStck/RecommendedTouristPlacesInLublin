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
    @Binding var userUserName: String
    @State private var showSheet: Bool = false
    @State var placesArr: [Place] = []
    @State private var changeDayNight: Bool = false
    @State private var selectedPlace: Place? = nil
    var body: some View {
        VStack{
            Toggle(isOn: $changeDayNight){
                if(changeDayNight == false){
                    Text("Zmień na tryb nocny").dayNightStyleText(toggle: changeDayNight)
                }else{
                    Text("Zmień na tryb dzienny").dayNightStyleText(toggle: changeDayNight)
                }
            }
            Spacer()
            if(!placesArr.isEmpty){
                List {
                    ForEach(placesArr, id: \.id){ place in
                        NavigationLink(destination: PlaceDetailsView(placeDesc: place.desc!, placeName: place.name!, placeLongitude: place.longitude!, placeLatitude: place.latitude!, userUserName: self.$userUserName)){
                            HStack(){
                                Text(place.name!).multilineTextAlignment(.leading).dayNightStyleText(toggle: self.changeDayNight)
                                Spacer()
                                Image(systemName: "star.fill").dayNightStyleBackgroundIcon(toggle: self.changeDayNight)
                                Text("Ocena: \(String(format: "%.2f", self.calculateRating(place: place)))").multilineTextAlignment(.trailing).dayNightStyleText(toggle: self.changeDayNight)
                                
                            }.gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local).onEnded({value in
                                if value.translation.width < 0{
                                    self.selectedPlace = place
                                }
                            }))
                        }
                    }.onDelete(perform: toggleSheet).dayNightStyleBackgroundList(toggle: changeDayNight)
                }.onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
            }
            Spacer()
            FooterView()
        }.onAppear(perform: addPlacesToArr).navigationBarTitle(selectedCategoryName).dayNightStyleBackground(toggle: changeDayNight).sheet(item: $selectedPlace){ place in
            ShowPlaceImage(imageString: place.imageName!).environment(\.managedObjectContext, self.viewContext)
            
        }.dayNightStyleBackground(toggle: changeDayNight)
    }
    
    func addPlacesToArr(){
        self.placesArr = getCategoryByName(viewContext: viewContext, categoryName: selectedCategoryName).placeArray
    }
    
    func toggleSheet(offsets: IndexSet){
        self.showSheet.toggle()
    }
    
    private func calculateRating(place: Place) -> Double{
        let opinions: [Opinion] = getPlaceByName(viewContext: viewContext, placeName: place.name!).opinionArray
        return  Double(opinions.reduce(0) { $0 + $1.rating })/Double(opinions.count)
        
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView(userUserName: .constant(""))
    }
}
