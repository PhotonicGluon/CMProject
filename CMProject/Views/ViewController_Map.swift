//
//  ViewController_Map.swift
//  CMProject
//
//  Created by Kan Onn Kit on 28/6/18.
//  Copyright © 2018 Kan Onn Kit. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class ViewController_Map: UIViewController {
    // Inputs
    
    // Outputs
    @IBOutlet weak var mapKitView: MKMapView!
    
    // Variables
    var attractions: [Attraction] = []
    let regionRadius: CLLocationDistance = 20000  // Set the view to regionRadius metres
    let initialLocation = CLLocation(latitude: 1.313251, longitude: 103.774345)
    
    // Func
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapKitView.setRegion(coordinateRegion, animated: true)
        print("Region Set")
    }
    
    override func viewDidLoad() {
        self.title = "Map"
        
        super.viewDidLoad()
        
        // Center map
        centerMapOnLocation(location: initialLocation)
        
        // Gather data
        let path = Bundle.main.path(forResource: "SGTouristLoc", ofType: "txt")
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path!)
        {
            let fullText = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            let readings = fullText.components(separatedBy: "\n")
            
            for i in 1..<readings.count-1
            {
                let attractionData = readings[i].components(separatedBy: "|")
                
                let title = attractionData[0]
                let locationDetail = attractionData[1]
                let locationType = attractionData[2]
                var location:CLLocationCoordinate2D
                if let latitude = Double(attractionData[3]), let longitude = Double(attractionData[4])
                {
                    location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                } else {
                    location = CLLocationCoordinate2D()
                }
                let imageLink = attractionData[5]
                
                attractions.append(Attraction(title: title, locationDetail: locationDetail, locationType: locationType, coordinate: location, imageLink: imageLink))
            }
            print("No. of attractions loaded: \(attractions.count)")
        }
        
        
        // Set up map
        mapKitView.delegate = self
        mapKitView.showsScale = true
        mapKitView.showsPointsOfInterest = true
        mapKitView.showsTraffic = true
        mapKitView.showsUserLocation = true
        mapKitView.register(AttractionMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        // Tourist Attractions
        mapKitView.addAnnotations(attractions)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController_Map: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Attraction
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

