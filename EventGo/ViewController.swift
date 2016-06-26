//
//  ViewController.swift
//  EventGo
//
//  Created by Daniel Ku on 6/25/16.
//  Copyright © 2016 djku. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var eventDescriptionField: UITextView!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
                  "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Lousiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
    //var pictureAddHelper: PictureAddHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        stateField.inputView = pickerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateField.text = states[row]
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let eventPageViewController = segue.destinationViewController as! EventPageViewController
        if segue.identifier == "EventPage"{
            //eventPageViewController.eventPage = Event()
            
            guard (eventNameField.text != "") else{
                let alertController = UIAlertController(title: "Error", message: "You didnt enter in an event title!", preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
                }
                alertController.addAction(closeAction)
                
                self.presentViewController(alertController, animated: true){
                }
                
                return
            }
            
            guard (dateField.text != "") else{
                let alertController = UIAlertController(title: "Error", message: "You didnt enter in a date!", preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
                }
                alertController.addAction(closeAction)
                
                self.presentViewController(alertController, animated: true){
                }
                
                return
            }

            
            guard (addressField.text != "") else{
                let alertController = UIAlertController(title: "Error", message: "You didnt enter in an address!", preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
                }
                alertController.addAction(closeAction)
                
                self.presentViewController(alertController, animated: true){
                }
                
                return
            }

            
            guard (cityField.text != "") else{
                let alertController = UIAlertController(title: "Error", message: "You didnt enter in a city!", preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
                }
                alertController.addAction(closeAction)
                
                self.presentViewController(alertController, animated: true){
                }
                
                return
            }
            
            guard (stateField.text != "") else{
                let alertController = UIAlertController(title: "Error", message: "You didnt enter in a state!", preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
                }
                alertController.addAction(closeAction)
                
                self.presentViewController(alertController, animated: true){
                }
                
                return
            }


            
            guard (Int(zipCodeField.text!) != nil) else{
                let alertController = UIAlertController(title: "Error", message: "You didnt enter in zip code!", preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
                }
                alertController.addAction(closeAction)
                
                self.presentViewController(alertController, animated: true){
                }
                
                return
            }
            
            guard (Double(costField.text!) != nil) else{
                let alertController = UIAlertController(title: "Error", message: "You didnt enter in a cost!", preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
                }
                alertController.addAction(closeAction)
                
                self.presentViewController(alertController, animated: true){
                }
                
                return
            }
            
            guard (eventDescriptionField.text != "") else{
                let alertController = UIAlertController(title: "Error", message: "You didnt enter in a description!", preferredStyle: .Alert)
                let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
                }
                alertController.addAction(closeAction)
                
                self.presentViewController(alertController, animated: true){
                }
                
                return
            }

//            //Sends data to the Event Page
//            eventPageViewController.eventPage?.eventName = eventNameField.text!
//            eventPageViewController.eventPage?.eventDate = dateField.text!
//            eventPageViewController.eventPage?.eventAddress = addressField.text!
//            eventPageViewController.eventPage?.eventCity = cityField.text!
//            eventPageViewController.eventPage?.eventState = stateField.text!
//            eventPageViewController.eventPage?.eventZipCode = Int(zipCodeField.text!)!
//            eventPageViewController.eventPage?.eventCost = Double(costField.text!)!
//            eventPageViewController.eventPage?.eventDescription = eventDescriptionField.text!
     }
    }
    
    @IBAction func dataField(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        dateField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    @IBAction func createEventButton(sender: AnyObject) {
    }
    
    @IBAction func addImageButton(sender: AnyObject) {
        print("choose photo")
        //pictureAddHelper!.showPhotoSourceSelection()
    }
    
    
    
}

