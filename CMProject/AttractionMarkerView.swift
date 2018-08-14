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
let ATTRACTION_DETAIL_FONT_SIZE = 14
let DETAIL_WIDTH = 250
let DETAIL_HEIGHT = 200

class AttractionMarkerView: MKMarkerAnnotationView {  // The things that will be shown when the attraction pin is tapped
    var detailData: NSDictionary = [:]
    var destData: NSDictionary = [:]
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let attraction = newValue as? Attraction else { return }
            // Make data
            detailData = ["title": attraction.title!, "detail": attraction.locationDetail, "credit": attraction.imageCredit]
            destData = ["title": attraction.title!]
            
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
            
            // Detail callout
            let detailCalloutView = UIView()
            let views = ["snapshotView": detailCalloutView]
            detailCalloutView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[snapshotView(\(DETAIL_WIDTH))]", options: [], metrics: nil, views: views))
            detailCalloutView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[snapshotView(\(DETAIL_HEIGHT))]", options: [], metrics: nil, views: views))
            
            // Configure More Info
            let detailsButton = UIButton(frame: CGRect(x: 0, y: DETAIL_HEIGHT - 35, width: DETAIL_WIDTH / 2 - 5, height: 35))
            detailsButton.setTitle("More Info", for: .normal)
            detailsButton.backgroundColor = UIColor.darkGray
            detailsButton.layer.cornerRadius = 5
            detailsButton.layer.borderWidth = 1
            detailsButton.layer.borderColor = UIColor.black.cgColor
            detailsButton.addTarget(self, action: #selector(self.moveToDetail), for: .touchDown)
            
            // Configure Directions
            let directionsButton = UIButton(frame: CGRect(x: DETAIL_WIDTH / 2 + 5, y: DETAIL_HEIGHT - 35, width: DETAIL_WIDTH / 2, height: 35))
            directionsButton.setTitle("Directions", for: .normal)
            directionsButton.backgroundColor = UIColor.darkGray
            directionsButton.layer.cornerRadius = 5
            directionsButton.layer.borderWidth = 1
            directionsButton.layer.borderColor = UIColor.black.cgColor
            directionsButton.addTarget(self, action: #selector(self.moveToDirections), for: .touchDown)
            
            // Configure detail label
            let detailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: DETAIL_WIDTH, height: DETAIL_HEIGHT - 40))
            detailLabel.numberOfLines = 0
            
            let formattedText = attraction.subtitle!.replacingOccurrences(of: "\\n", with: "\n")  // Correctly format text with linebreaks
            
            detailLabel.text = formattedText
            detailLabel.font = detailLabel.font.withSize(CGFloat(ATTRACTION_DETAIL_FONT_SIZE))
            
            // Adding items to view
            detailCalloutView.addSubview(detailLabel)
            detailCalloutView.addSubview(detailsButton)
            detailCalloutView.addSubview(directionsButton)
            
            // Set accessory
            detailCalloutAccessoryView = detailCalloutView
        }
    }
    // Listener functions
    @objc func moveToDetail()
    {
        NotificationCenter.default.post(name: NSNotification.Name("MoveToDetail"), object: nil, userInfo: detailData as? [String : Any])
    }
    
    @objc func moveToDirections()
    {
        NotificationCenter.default.post(name: NSNotification.Name("MoveToDirections"), object: nil, userInfo: destData as? [String : Any])
    }
}
