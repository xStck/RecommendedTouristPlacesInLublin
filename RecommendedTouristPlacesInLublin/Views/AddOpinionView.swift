//
//  AddOpinionView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import CoreData

struct AddOpinionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    var placeName: String = ""
    var userUserName: String = ""
    
    @State private var userRate: Int16 = 0
    @State private var userContent: String = ""
    @State private var goodRate: Bool = false
    @Binding var opinions: [Opinion]
    @Binding var changeDayNight: Bool
    
    var body: some View {
        VStack{
            ToggleView(changeDayNight: $changeDayNight)
            
            Spacer()
            
            Text("Cześć \(userUserName), czekamy na Twoją opinię!")
                .dayNightStyleText(toggle: changeDayNight)
            Text("Podaj ocenę w skali od 1 do 5")
                .dayNightStyleText(toggle: changeDayNight)
            TextField("", text: Binding(
                get:{String(self.userRate)},
                set:{ self.userRate = Int16($0) ?? 0
                    if((self.userRate >= 1 && self.userRate <= 5)){
                        self.userRate = Int16($0)!
                        self.goodRate = true
                    }else{
                        self.goodRate = false
                    }
            }
                )
            )
                .underlineTextFieldStyle()
            
            Text("Napisz co myślisz o tym lokalu (opcjonalnie): ")
                .dayNightStyleText(toggle: changeDayNight)
            TextField("", text: $userContent)
                .underlineTextFieldStyle()
            
            if(self.goodRate){
                Button(action: self.addOpinion){
                    Text("Dodaj opinię")
                        .buttonCustomStyle()
                }
            }else{
                Text("Aby dodać opinię, podaj prawidłowe dane")
                    .foregroundColor(Color.red)
            }
            
            Spacer()
        }
        .frame(minHeight: 0, maxHeight: .infinity)
        .dayNightStyleBackground(toggle: changeDayNight)
    }
    
    private func addOpinion(){
        let newOpinion = Opinion(context: viewContext)
        
        newOpinion.id = UUID()
        newOpinion.rating  = userRate
        newOpinion.content  = userContent
        newOpinion.place  = getPlaceByName(viewContext: viewContext, placeName: placeName)
        newOpinion.user  = getUserByUserName(viewContext: viewContext, userName: userUserName)
        
        do{
            try viewContext.save()
        }catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        self.addOpinions()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func addOpinions(){
        self.opinions = getPlaceByName(viewContext: viewContext, placeName: placeName).opinionArray
    }
}


struct AddOpinionView_Previews: PreviewProvider {
    static var previews: some View {
        AddOpinionView(opinions: .constant([Opinion]()), changeDayNight: .constant(false))
    }
}
