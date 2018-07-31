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
let MAP_BTN_IMG_SIZE = 32

class AttractionMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let attraction = newValue as? Attraction else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            let attractionImgDisplay = UIImageView()
            attractionImgDisplay.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: ATTRACTION_IMAGE_SIZE, height: ATTRACTION_IMAGE_SIZE))
            
            let url = URL(string: attraction.imageFile)
            
            do
            {
                let data = try Data(contentsOf: url!)
                attractionImgDisplay.image = UIImage(data: data)
                
            } catch {  // If there is an error
                attractionImgDisplay.image = #imageLiteral(resourceName: "CMProject-NoImageDetected.png")
            }
            
            leftCalloutAccessoryView = attractionImgDisplay

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
