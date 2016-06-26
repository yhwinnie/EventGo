//
//  MapViewController.swift
//  EventGo
//
//  Created by Winnie Wen on 6/25/16.
//  Copyright © 2016 wiwen. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var addresses = ["47 Seashore Drive, Daly City, CA 94014", "1541 Oxford Street, Berkeley, CA 94709"]
    
    let locationManager = CLLocationManager()
    
    var myLocation:CLLocationCoordinate2D?
    
    var eventClicked = Event()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]) {
        
        if (!locations.isEmpty)
        {
            
            let myLocation  = locations[0] as! CLLocation
            
            
            mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(myLocation.coordinate.latitude, myLocation.coordinate.longitude), MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
        
    }

    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //centerMapOnLocation(initialLocation)
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        

        
        self.mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        mapView.delegate = self
        mapView.mapType = .Standard
        //mapView.zoomEnabled = true
        //mapView.scrollEnabled = true
        mapView.showsUserLocation = true
//        
//        if let coor = mapView.userLocation.location?.coordinate{
//            mapView.setCenterCoordinate(coor, animated: true)
//        }
        


        let apiURL = NSURL(string: "http://curtastic.com/eventtogo/?action=getevents")
        let request = NSURLRequest(URL: apiURL!)
        
        print("BB")
        // Create a task
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            
            (data, reponse, error) in
            
            if error == nil {
                print("CC")
                
                guard let data = data else {
                    
                    print("No data was returned by the request!")
                    return
                }
                let parsedResult: AnyObject!
                
                do {
                    // Serialize means converting object to streams of bytes
                    print(data)
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    print(parsedResult)
                } catch {
                    print("Coult not parse the data as JSON: '\(data)'")
                    return
                }
                
                if let dictionary = parsedResult["events"] {
                    print(dictionary)
                    
                    for each in dictionary as! [[String: String]] {
                        print(each["name"]!)
                        
                        print(each["street"]!)
                        
                        var location: String = each["street"]!
                        var geocoder: CLGeocoder = CLGeocoder()
                        geocoder.geocodeAddressString(location,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                            if (placemarks?.count > 0) {
                                var topResult: CLPlacemark = (placemarks?[0])!
                                
                                var placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                                
                                var coordinates:CLLocationCoordinate2D = topResult.location!.coordinate
                                var region: MKCoordinateRegion = self.mapView.region
                                //region.center = placemark.region!.center
                                //self.mapView.setRegion(region, animated: true)
                                var pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                                pointAnnotation.coordinate = coordinates
                                region.span.longitudeDelta /= 8.0
                                region.span.latitudeDelta /= 8.0
                                
                                pointAnnotation.title = "\(each["name"]!)"
                                pointAnnotation.subtitle = "\(each["street"]!)"
                                
                                self.mapView.addAnnotation(pointAnnotation)
                                self.mapView.centerCoordinate = coordinates
                                self.mapView.selectAnnotation(pointAnnotation, animated: true)
                                self.mapView.setRegion(region, animated: true)
                                //self.mapView.addAnnotation(placemark)
                            }
                        })
                    }
                }
            }
        }
        task.resume()
        
        for address in addresses {
            var location: String = address
            var geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString(location,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                if (placemarks?.count > 0) {
                    var topResult: CLPlacemark = (placemarks?[0])!
                    var placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                    var region: MKCoordinateRegion = self.mapView.region
                    //region.center = placemark.region!.center
                    //self.mapView.setRegion(region, animated: true)
                    var coordinates:CLLocationCoordinate2D = topResult.location!.coordinate
                    var pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                    pointAnnotation.coordinate = coordinates
                    region.span.longitudeDelta /= 8.0
                    region.span.latitudeDelta /= 8.0
                    
                    pointAnnotation.title = "\(address)"
                    pointAnnotation.subtitle = "Event name"
                    
                    
                    self.mapView.addAnnotation(pointAnnotation)
                    self.mapView.centerCoordinate = coordinates
                    self.mapView.selectAnnotation(pointAnnotation, animated: true)
                    self.mapView.setRegion(region, animated: true)
                    region.span.longitudeDelta /= 8.0
                    region.span.latitudeDelta /= 8.0
                    self.mapView.setRegion(region, animated: true)
                    //self.mapView.addAnnotation(placemark)
                }
            })
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Purple
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func pinPressed(mapView: MKMapView!, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            print("Disclosure Pressed!")
        }
    }
    
    var selectedAnnotation: MKPointAnnotation!
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            selectedAnnotation = view.annotation as? MKPointAnnotation
            eventClicked.name = selectedAnnotation.title!
            eventClicked.address = selectedAnnotation.subtitle!
            
            let eventViewController = EventPageViewController()
            eventViewController.event = eventClicked
            
            print(eventClicked.name)
            
            

            
        }
    }
    

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? EventPageViewController {
            
            if segue.identifier == "pinView" {
                let eventPageViewController = segue.destinationViewController as! EventPageViewController
            eventPageViewController.event = eventClicked
            
            
            
                performSegueWithIdentifier("pinView", sender: self)
            }
            
            
            

        }
    }

    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
