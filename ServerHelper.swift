//
//  ServerHelper.swift
//  EventGo
//
//  Created by Nicholas Swift on 6/25/16.
//  Copyright © 2016 djku. All rights reserved.
//

import Foundation

class ServerHelper {
    
    // Attempt to log in
    static var userLoggedIn: Bool!
    static func attemptLogIn(email: String!, password: String!) {
        userLoggedIn = nil
        
        // If there's nothing in email or password, just return false, no need to check
        if email == nil || email == "" || password == nil || password == "" {
            userLoggedIn = false
            return
        }
        
        // Set up the request
        let str = String("http://curtastic.com/eventtogo/?action=login&email=" + email + "&password=" + password)
        let apiURL = NSURL(string: str)
        let request = NSURLRequest(URL: apiURL!)
        
        // Create a task
        let task = NSURLSession.sharedSession().dataTaskWithURL(request.URL!) {
            (data, response, error) in
            
            if error == nil {
                guard let data = data else {
                    print("No data was returned by the request!")
                    userLoggedIn = false
                    return
                }
                
                let parsedResult: AnyObject!
                
                do {
                    // Serialize means converting object to streams of bytes
                    print(data)
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    print(parsedResult)
                }
                catch {
                    print("Could not parse the data as JSON: '\(data)'")
                    userLoggedIn = false
                    return
                }
                
                if let dictionary = parsedResult["user"] {
                    print(dictionary)
                    if dictionary == nil {
                        userLoggedIn = false
                    }
                    else {
                        userLoggedIn = true
                    }
                    return
                }
            }
        }
        
        task.resume()
        
        while(ServerHelper.userLoggedIn == nil) {
            //stall
        }
        
        return
    }
    
    // Create user
    static var userCreated: Bool!
    static func createUser(email: String!, password: String!, firstName: String!, lastName: String!) {
        userCreated = nil
        
        // Set up the request
        let str = String("http://curtastic.com/eventtogo/?action=adduser&email" + email + "&password" + password + "&firstname" + firstName + "&lastname" + lastName)
        let apiURL = NSURL(string: str)
        let request = NSURLRequest(URL: apiURL!)
        
        // Create a task
        let task = NSURLSession.sharedSession().dataTaskWithURL(request.URL!) {
            (data, response, error) in
            
            if error == nil {
                guard let data = data else {
                    print("No data was returned by the request!")
                    userCreated = false
                    return
                }
                
                let parsedResult: AnyObject!
                
                do {
                    // Serialize means converting object to streams of bytes
                    print(data)
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    print(parsedResult)
                }
                catch {
                    print("Could not parse the data as JSON: '\(data)'")
                    userCreated = false
                    return
                }
                
                if let dictionary = parsedResult["user"] {
                    print(dictionary)
                    if dictionary == nil {
                        userCreated = false
                    }
                    else {
                        userCreated = true
                    }
                    return
                }
            }
        }
        
        task.resume()
        return
    }
    
    static func retreiveEvents() {
        
        // Set up the request
        let apiURL = NSURL(string: "STRINGHEREPLEASE")
        let request = NSURLRequest(URL: apiURL!)
        
        // Create a task
        let task = NSURLSession.sharedSession().dataTaskWithURL(request.URL!) {
            (data, response, error) in
            
            if error == nil {
                guard let data = data else { print("No data was returned by the request!"); return }
                
                let parsedResult: AnyObject!
                
                do {
                    // Serialize means converting object to streams of bytes
                    print(data)
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    print(parsedResult)
                }
                catch {
                    print("Could not parse the data as JSON: '\(data)'")
                    return
                }
                
                if let dictionary = parsedResult["events"] {
                    print(dictionary)
                
                    for each in dictionary as! [[String: String]] {
                        print(each["userid"]!)
                    }
                }
            }
        }
        
        task.resume()
        return
    }
    
    // Retreive events
    static var eventsRetreived: Bool!
    static func retreiveEvents() -> [Event] {
        let events: [Event] = []
        eventsRetreived = nil
        
        // Set up the request
        let str = String("http://curtastic.com/eventtogo/?action=getevents")
        let apiURL = NSURL(string: str)
        let request = NSURLRequest(URL: apiURL!)
        
        // Create a task
        let task = NSURLSession.sharedSession().dataTaskWithURL(request.URL!) {
            (data, response, error) in
            
            if error == nil {
                guard let data = data else {
                    print("No data was returned by the request!")
                    eventsRetreived = false
                    return
                }
                
                let parsedResult: AnyObject!
                
                do {
                    // Serialize means converting object to streams of bytes
                    print(data)
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    print(parsedResult)
                }
                catch {
                    print("Could not parse the data as JSON: '\(data)'")
                    eventsRetreived = false
                    return
                }
                
                if let dictionary = parsedResult["events"] {
                    print(dictionary)
                    
                    for dictEvent in dictionary as! [[String: String]] {
                        
                        let event = Event()
                        event.name = dictEvent["name"]!
                        event.address = dictEvent["street"]!
                        event.city = dictEvent["city"]!
                        event.state = dictEvent["state"]!
                        event.zipCode = dictEvent["zip"]!
                        event.description = dictEvent["description"]!
                        event.date = dictEvent["startTime"]!
                        event.cost = "20"
                    }
                    
                    eventsRetreived = true
                    return
                }
            }
        }
        
        task.resume()
        while(ServerHelper.userLoggedIn == nil) {
            //stall
        }
        
        return events
    }
    

}