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
            let data = try? Data(contentsOf: url!) // Make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            attractionImageDisplay.image = UIImage(data: data!)
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
