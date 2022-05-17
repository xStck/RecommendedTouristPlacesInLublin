//
//  RatingStar.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI

struct RatingStar: View {
    var rating: CGFloat
    var color: Color
    var index: Int
    
    
    var maskRatio: CGFloat {
        let mask = rating - CGFloat(index)
        
        switch mask {
        case 1...: return 1
        case ..<0: return 0
        default: return mask
        }
    }
    
    
    init(rating: Decimal, color: Color, index: Int) {
        // Why decimal? Decoding floats and doubles is not accurate.
        self.rating = CGFloat(Double(rating.description) ?? 0)
        self.color = color
        self.index = index
    }
    
    
    var body: some View {
        GeometryReader { star in
            Image(systemName: "star.fill").resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundColor(self.color)
                .mask(
                    Rectangle()
                        .size(
                            width: star.size.width * self.maskRatio,
                            height: star.size.height
                    )
                    
            )
        }
    }
}

struct RatingStar_Previews: PreviewProvider {
    static var previews: some View {
        RatingStar(rating: Decimal(0.0), color: Color.red, index: 0)
    }
}
