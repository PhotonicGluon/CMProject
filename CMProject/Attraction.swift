//
//  Attraction.swift
//  CMProject
//
//  Created by Kan Onn Kit on 7/7/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Attraction: NSObject, MKAnnotation {
    let title: String?
    let shortDesc: String
    let locationDetail: String
    let locationType: String
    let coordinate: CLLocationCoordinate2D
    let imageCredit: String
    
    init(title: String, shortDesc: String, locationDetail:String, locationType: String, coordinate: CLLocationCoordinate2D, imageCredits: String) {
        self.title = title
        self.shortDesc = shortDesc
        self.locationDetail = locationDetail
        self.locationType = locationType
        self.coordinate = coordinate
        self.imageCredit = imageCredits
        
        super.init()
    }
    
    var subtitle: String? {
        return shortDesc
    }
    var markerTintColor: UIColor  {
        switch locationType {
        case "Action":
            return .red
        case "Casual":
            return .green
        case "Sights":
            return .orange
        case "Shopping":
            return .blue
        default:
            return .cyan  // Default but will never be used
        }
    }
    
    var imageName: String? {
        if locationType == "Action" { return "Adventure" }
        else if locationType == "Sights" { return "Binoculars" }
        else if locationType == "Shopping" { return "Shopping" }
        return "Flag"
    }
}
