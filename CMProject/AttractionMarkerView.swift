//
//  AttractionMarkerView.swift
//  CMProject
//
//  Created by Kan Onn Kit on 7/7/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
//

import Foundation
import MapKit

let ATTRACTION_IMAGE_SIZE = 128

class AttractionMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let attraction = newValue as? Attraction else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            let attractionImageDisplay = UIImageView()
            
            let url = URL(string: attraction.imageLink)
            if let data = try? Data(contentsOf: url!)
            {
                attractionImageDisplay.image = UIImage(data: data)
            } else {
                print("Error: Image from \(attraction.imageLink) cannot be loaded. Loading default image.")
                attractionImageDisplay.image = #imageLiteral(resourceName: "CMProject-NoImageDetected.png")
            }
            
            attractionImageDisplay.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: ATTRACTION_IMAGE_SIZE, height: ATTRACTION_IMAGE_SIZE))
            leftCalloutAccessoryView = attractionImageDisplay
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Maps-Icon"), for: UIControlState())
            rightCalloutAccessoryView = mapsButton
            markerTintColor = attraction.markerTintColor
            
            if let imageName = attraction.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
                glyphText = String(attraction.locationType.first!)
            }
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = attraction.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}
