//
//  AttractionMarkerView.swift
//  CMProject
//
//  Created by Kan Onn Kit on 7/7/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
//

import Foundation
import MapKit
//import FileProvider

let ATTRACTION_IMAGE_SIZE = 128
let MAP_BTN_IMG_SIZE = 32

class AttractionMarkerView: MKMarkerAnnotationView {  // The things that will be shown when the attraction pin is tapped
    override var annotation: MKAnnotation? {
        willSet {
            guard let attraction = newValue as? Attraction else { return }
            // Misc
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            // Image
            let attractionImgDisplay = UIImageView()
            attractionImgDisplay.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: ATTRACTION_IMAGE_SIZE, height: ATTRACTION_IMAGE_SIZE))
            
            if let img = UIImage(named: attraction.title!)  // The title is the same as the image name
            {
                attractionImgDisplay.image = img
            } else {
                print("Error: \(attraction.title!) image cannot be loaded.")
                attractionImgDisplay.image = #imageLiteral(resourceName: "CMProject-NoImageDetected.png")
            }
            
            leftCalloutAccessoryView = attractionImgDisplay
            
            // Tint
            markerTintColor = attraction.markerTintColor
            
            // Glyph image
            if let imageName = attraction.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
                glyphText = String(attraction.locationType.first!)
            }
            
            // Detail label
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = attraction.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}
