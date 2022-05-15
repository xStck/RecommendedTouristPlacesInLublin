//
//  ContentView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var userName: String = ""
    
    var body: some View {
        VStack(){
            Text("PODAJ NAZWĘ UŻYTKOWNIKA").font(.title)
            TextField("Nazwa użytkownika", text: $userName).underlineTextFieldStyle()
            Button(action: {print("")}){
                Text("Przejdź dalej").buttonStyle()
            }
            Spacer()
            Text("Test")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
