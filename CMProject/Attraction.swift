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
    let locationDetail: String
    let locationType: String
    let coordinate: CLLocationCoordinate2D
    let imageLink: String
    
    init(title: String, locationDetail:String, locationType: String, coordinate: CLLocationCoordinate2D, imageLink:String) {
        self.title = title
        self.locationDetail = locationDetail
        self.locationType = locationType
        self.coordinate = coordinate
        self.imageLink = imageLink
        
        super.init()
    }
    
    init?(attractionData: [Any]) {
        self.title = attractionData[0] as? String
        self.locationDetail = attractionData[1] as! String
        self.locationType = attractionData[2] as! String
        if let latitude = Double(attractionData[3] as! String),
            let longitude = Double(attractionData[4] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
        self.imageLink = attractionData[5] as! String
    }
    
    
    var subtitle: String? {
        return locationDetail
    }
    
    var markerTintColor: UIColor  {
        switch locationType {
        case "Action":
            return .red
        case "Casual":
            return .cyan
        case "Sights":
            return .blue
        default:
            return .green
        }
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    var imageName: String? {
        if locationType == "Action" { return "Adventure" }
        else if locationType == "Sights" { return "Binoculars" }
        return "Flag"
    }
}
