//
//  FooterView.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack{
            Text("Autorzy:")
            Text("Nalepa Dawid - 92963\nOleszko Tomasz - 92974\nOgorzałek Daniel - 92972")
            }.frame(minWidth: 0, maxWidth: .infinity).background(Color.black).foregroundColor(Color.white).padding(0)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
