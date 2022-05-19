//
//  ToggleView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 19/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI

struct ToggleView: View {
    @Binding var changeDayNight: Bool
    var body: some View {
        HStack{
            Toggle(isOn: $changeDayNight){
                if(changeDayNight == false){
                    Text("Zmień na tryb nocny")
                        .dayNightStyleText(toggle: changeDayNight)
                }else{
                    Text("Zmień na tryb dzienny")
                        .dayNightStyleText(toggle: changeDayNight)
                }
            }
            .padding()
        }
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView(changeDayNight: .constant(false))
    }
}
