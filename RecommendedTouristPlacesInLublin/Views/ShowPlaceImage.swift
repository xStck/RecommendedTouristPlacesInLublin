//
//  ShowPlaceImage.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by student on 18/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI

struct ShowPlaceImage: View {
    var imageString: String = ""
    var placeName: String = ""
    @Binding var changeDayNight: Bool

    var body: some View {
        VStack(alignment: .leading){
            
            ToggleView(changeDayNight: $changeDayNight)
            
            Text(placeName).font(.largeTitle).dayNightStyleText(toggle: changeDayNight)
            Image(imageString).resizable().aspectRatio(contentMode: .fit)
            
           
            
        }.frame(height: UIScreen.main.bounds.size.height).dayNightStyleBackground(toggle: changeDayNight)
    }
}

struct ShowPlaceImage_Previews: PreviewProvider {
    static var previews: some View {
        ShowPlaceImage(changeDayNight: .constant(false))
    }
}
