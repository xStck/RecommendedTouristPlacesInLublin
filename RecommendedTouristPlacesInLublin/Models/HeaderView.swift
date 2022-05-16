//
//  HeaderView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("Turystyczny Lublin").fontWeight(.bold).font(.title).frame(minWidth: 0, maxWidth:  .infinity).background(Color.blue).foregroundColor(Color.white).padding(0)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
