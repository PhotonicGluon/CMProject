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
    
    // Func
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span = MKCoordinateSpanMake(0.5, 0.5)

        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegionMake(myLocation, span)
        
        mapKitView.setRegion(region, animated: true)
        self.mapKitView.showsUserLocation = true
    }
    
    // Main Functions
    override func viewDidLoad() {
        self.title = "Map"
        
        super.viewDidLoad()

        mapKitView.delegate = self
        mapKitView.showsScale = true
        mapKitView.showsPointsOfInterest = true
        mapKitView.showsTraffic = true
        mapKitView.showsUserLocation = true
        mapKitView.register(AttractionMarkerView.self,forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        // Tourist Attractions
        let singaporeZoo = Attraction(title: "Singapore Zoo", locationDetail: "The Singapore Zoo, formerly known as the Singapore Zoological Gardens and commonly known locally as the Mandai Zoo, occupies 28 hectares (69 acres) on the margins of Upper Seletar Reservoir within Singapore's heavily forested central catchment area.", locationType: "Casual", coordinate: CLLocationCoordinate2D(latitude: 1.4043, longitude: 103.7930), imageLink: "https://www.straitstimes.com/sites/default/files/articles/2018/04/17/nm-zoo-1704.jpg")
        
        // Add those attractions
        mapKitView.addAnnotation(singaporeZoo)

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

