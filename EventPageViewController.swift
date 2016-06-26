//   eventNameLabel.text
//
//  EventPageViewController.swift
//  EventGo
//
//  Created by Daniel Ku on 6/25/16.
//  Copyright © 2016 djku. All rights reserved.
//

import UIKit

class EventPageViewController: UIViewController {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var event = Event()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Retrieve data from ViewController and insert into text fields of the labels
//        eventNameLabel.text = eventPage!.eventName
//        dateLabel.text = eventPage!.eventDate
//        addressLabel.text = eventPage!.eventAddress
//        stateLabel.text = eventPage!.eventState
//        cityLabel.text = eventPage!.eventCity
//        zipCodeLabel.text = String(eventPage!.eventZipCode)
//        costLabel.text = "$" + String(eventPage!.eventCost)
//        descriptionTextView.text = eventPage!.eventDescription
        print(event.name)
        
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
