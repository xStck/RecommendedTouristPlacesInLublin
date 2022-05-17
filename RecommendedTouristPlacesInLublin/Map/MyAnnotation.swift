//
//  MyAnnotation.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation: NSObject, MKAnnotation{
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?,  subtitle: String?,  coordinate: CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
