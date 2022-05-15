//
//  customStyle.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 15/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//
import SwiftUI



extension View {
    func underlineTextFieldStyle() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.blue)
            .padding(10)
    }
    
    func buttonStyle() -> some View {
        self
            .font(.title).padding(10).background(Color.blue).cornerRadius(40).foregroundColor(.white)
    }
    
    
}