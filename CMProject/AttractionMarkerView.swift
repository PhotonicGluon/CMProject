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
    func getImage(url:String) -> UIImageView
    {
        let attractionImageDisplay = UIImageView()
        attractionImageDisplay.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: ATTRACTION_IMAGE_SIZE, height: ATTRACTION_IMAGE_SIZE))
        
        let url = URL(string: url)
        
        do
        {
            let data = try Data(contentsOf: url!)
            attractionImageDisplay.image = UIImage(data: data)
            
        } catch {  // If there is an error
            attractionImageDisplay.image = #imageLiteral(resourceName: "CMProject-NoImageDetected.png")
        }
        
        return attractionImageDisplay
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let attraction = newValue as? Attraction else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            
            let attractionImgDisplay = getImage(url: attraction.imageLink)  // Process using guard
            leftCalloutAccessoryView = attractionImgDisplay
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: MAP_BTN_IMG_SIZE, height: MAP_BTN_IMG_SIZE)))
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
