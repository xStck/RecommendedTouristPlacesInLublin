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
    
    func buttonCustomStyle() -> some View {
        self
            .foregroundColor(.white)
            .padding(4)
            .background(Color.blue)
            .cornerRadius(4)
    }
    
    func dayNightStyleText(toggle: Bool) -> some View {
        if(toggle){
            return self.foregroundColor(Color.white)
        }else{
            return self.foregroundColor(Color.black)
        }
    }
    
    func dayNightStyleBackground(toggle: Bool) -> some View {
        if(toggle == false){
            return self.background(Color.white)
        }else{
            return self.background(Color.black)
        }
    }
    
    func dayNightStyleBackgroundList(toggle: Bool) -> some View {
        if(toggle == false){
            return self.listRowBackground(Color.white)
        }else{
            return self.listRowBackground(Color.black)
        }
    }
    
    func dayNightStyleBackgroundIcon(toggle: Bool) -> some View{
        if(toggle){
            return self.foregroundColor(Color.white)
        }else{
            return self.foregroundColor(Color.black)
        }
    }
}
