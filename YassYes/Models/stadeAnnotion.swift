//
//  stadeAnnotion.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 04/12/2021.
//

import Foundation
import MapKit


class StadiumAnnotation: NSObject, MKAnnotation {
    var stade: stadeModel
    var title: String?
    //var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(_ stade: stadeModel) {
        self.stade = stade
        self.title = self.stade.nom
        self.coordinate = CLLocationCoordinate2D(latitude: self.stade.lat, longitude: self.stade.lon)
        //self.subtitle = "Capaicté: \(self.stade.capacity) places"
    }
}
