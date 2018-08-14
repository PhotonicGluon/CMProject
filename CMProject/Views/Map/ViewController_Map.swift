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
    // MARK: Inputs
    
    // MARK: Outputs
    @IBOutlet weak var mapKitView: MKMapView!
    
    // MARK: Variables
    var attractions: [Attraction] = []  // Create an array which ONLY accepts Attraction objects
    let regionRadius: CLLocationDistance = 25000  // Set the view to regionRadius metres
    let initialLocation = CLLocation(latitude: 1.3521, longitude: 103.8198)  // Center of SG
    
    var passedData:NSArray = []
    
    // MARK: Func
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapKitView.setRegion(coordinateRegion, animated: true)
    }
    
    // Prepare movement functions
    func catchData(notification: Notification) -> Void
    {
        if notification.userInfo!.count == 1  // Only applies to directions
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Directions") as! ViewController_Directions

            let userInfo = notification.userInfo! as! [String: String]
            
            guard let title = userInfo["title"] else { print("No title"); return }
            
            newViewController.locationTitle = title
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        else  // Only applies to detail
        {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ExtraDetail") as! ViewController_ExtraDetail
            
            let userInfo = notification.userInfo! as! [String: String]
            
            guard let title = userInfo["title"] else { print("No title"); return }
            guard let detail = userInfo["detail"] else { print("No detail"); return }
            guard let credits = userInfo["credit"] else { print("No image"); return }

            newViewController.attractionTitle = title
            newViewController.attractionImage = UIImage(named: title)
            newViewController.attractionDetail = detail
            newViewController.imageCredits = credits
            
            self.navigationController?.pushViewController(newViewController, animated: true)

        }
    }
    
    override func viewDidLoad() {
        print()
        print("LOADING 'MAP' VIEW CONTROLLER")
        self.title = "Map"
        super.viewDidLoad()
        // Create listeners
        NotificationCenter.default.addObserver(forName: NSNotification.Name("MoveToDetail"), object: nil, queue: nil, using: catchData)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("MoveToDirections"), object: nil, queue: nil, using: catchData)
        
        // Setup delegate for map
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
                let attractionData = readings[i].components(separatedBy: "|")  // Because we can't use ",", therefore "|" has to do
                
                let title = attractionData[0]
                let locationType = attractionData[1]
                var location:CLLocationCoordinate2D
                if let latitude = Double(attractionData[2]), let longitude = Double(attractionData[3])
                {
                    location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                } else {
                    location = CLLocationCoordinate2D()
                }
                let shortDesc = attractionData[4]
                let locationDetail = attractionData[5]
                let imageCredit = attractionData[6]
                
                attractions.append(Attraction(title: title, shortDesc: shortDesc, locationDetail: locationDetail, locationType: locationType, coordinate: location, imageCredits: imageCredit))
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
