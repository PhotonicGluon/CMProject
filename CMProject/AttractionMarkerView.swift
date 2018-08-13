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

let ATTRACTION_IMAGE_SIZE = 64
let ATTRACTION_DETAIL_FONT_SIZE = 10

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
                attractionImgDisplay.image = img  // Load the image
            } else {
                print("Error: \(attraction.title!)'s image cannot be loaded.")
                attractionImgDisplay.image = #imageLiteral(resourceName: "CMProject-NoImageDetected.png")  // The "No-Image" image file
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
            
            let formattedText = attraction.subtitle!.replacingOccurrences(of: "\\n", with: "\n")  // Correctly format text with linebreaks
            
            detailLabel.text = formattedText
            detailLabel.font = detailLabel.font.withSize(CGFloat(ATTRACTION_DETAIL_FONT_SIZE))
            detailCalloutAccessoryView = detailLabel
            
            // More details button
            let mapsButton = UIButton(type: .detailDisclosure)
            rightCalloutAccessoryView = mapsButton
        }
    }
}
