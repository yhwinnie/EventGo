//
//  User.swift
//  EventGo
//
//  Created by Nicholas Swift on 6/25/16.
//  Copyright © 2016 djku. All rights reserved.
//

import Foundation

class User {
    
    // Variables for user info
    var firstName: String!
    var lastName: String!
    
    var username: String!
    var email: String!
    
    var id: String!
    var facebookId: String!
    
    // Variables for user properties and stuff
    var location: String!
    var ownEvents: [Event]!
    
    init() {
        
    }
}