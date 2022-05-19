//
//  MapCreator.swift
//  RecommendedTouristPlacesInLublin
//
//  Created by Dawid Nalepa on 17/05/2022.
//  Copyright © 2022 NalepaDawid_OgorzalekDaniel_OleszkoTomasz. All rights reserved.
//

import SwiftUI
import MapKit

struct MapCreator: UIViewRepresentable{
    
    @Binding var myAnnotation : MyAnnotation
    @Binding var resize: Double
    
    func makeUIView(context: Context) -> MKMapView {
        let myMap = MKMapView(frame: .zero)
        return myMap
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(MKCoordinateRegion(center: myAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: self.resize, longitudeDelta: self.resize)), animated: true)
        uiView.addAnnotations([myAnnotation])
    }
}

struct MapCreator_Previews: PreviewProvider {
    static var previews: some View {
        MapCreator(myAnnotation: .constant(MyAnnotation(title: "s", subtitle: "s", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))), resize: .constant(0.0))
    }
}

