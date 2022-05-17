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
    @State private var userRate: Int16 = 0
    @State private var userContent: String = ""
    @State private var goodRate: Bool = true
    @Binding var opinions: [Opinion]
    var body: some View {
        VStack{
            Text("Cześć TEST, czekamy na Twoją opinię!")
            
            Text("Podaj ocenę w skali od 1 do 5")
            TextField("Ocena", text: Binding(
                get:{String(self.userRate)},
                set:{ self.userRate = Int16($0) ?? 0
                    if((self.userRate >= 1 && self.userRate <= 5)){
                        self.userRate = Int16($0)!
                        self.goodRate = false
                    }else{
                        self.goodRate = true
                    }
            }
            )).underlineTextFieldStyle()
            
            Text("Napisz co myślisz o tym lokalu: ")
            TextField("Opinia (opcjonalnie)", text: $userContent).underlineTextFieldStyle()
            
         
                Button(action: self.addOpinion){
                    Text("Dodaj opinię")
                }.disabled(self.goodRate)
            
        }
    }
    
    private func addOpinion(){
        let newOpinion = Opinion(context: viewContext)
        let userName = "Andrzej"
        newOpinion.id = UUID()
        newOpinion.rating  = userRate
        newOpinion.content  = userContent
        newOpinion.place  = getPlaceByName(viewContext: viewContext, placeName: placeName)
        newOpinion.user  = getUserByUserName(viewContext: viewContext, userName: userName)
        
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
        AddOpinionView(opinions: .constant([Opinion]()))
    }
}
