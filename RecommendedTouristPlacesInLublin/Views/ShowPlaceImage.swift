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
    var body: some View {
        Image(imageString)
    }
}

struct ShowPlaceImage_Previews: PreviewProvider {
    static var previews: some View {
        ShowPlaceImage()
    }
}
