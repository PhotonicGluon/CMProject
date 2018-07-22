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

class ViewController_Map: UIViewController, MKMapViewDelegate {
    // Inputs
    
    // Outputs
    @IBOutlet weak var mapKitView: MKMapView!
    
    // Variables
    var attractions: [Attraction] = []  // Create an array which ONLY accepts Attraction objects
    let regionRadius: CLLocationDistance = 20000  // Set the view to regionRadius metres
    let initialLocation = CLLocation(latitude: 1.313251, longitude: 103.774345)  // SST ;)
    
    var hamburgerMenuVisible = false
    
    // Func
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapKitView.setRegion(coordinateRegion, animated: true)
    }
    
    
    override func viewDidLoad() {
        print()
        print("LOADING 'MAP' VIEW CONTROLLER")
        self.title = "Map"
        super.viewDidLoad()

        mapKitView.delegate = self
        mapKitView.register(AttractionMarkerView.self,
                                 forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        print("MARK: Gathering data")
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
        }
        
        let loadingWheel = UIViewController.displaySpinner(onView: self.view)  // Create spinner
        DispatchQueue.global(qos: .background).async  // Slower than the main
        {
            self.mapKitView.addAnnotations(self.attractions)
            UIViewController.removeSpinner(spinner: loadingWheel)
            
            print("Loaded annotations.")
            print("No. of attractions loaded: \(self.attractions.count)")  // Finished then show
        }
        
        DispatchQueue.main.async
        {
            self.centerMapOnLocation(location: self.initialLocation)
        }
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



extension UIViewController {   // Create a spinning loading wheel
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)  // Grey
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
