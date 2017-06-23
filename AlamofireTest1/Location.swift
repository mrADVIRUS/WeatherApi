//
//  Location.swift
//  AlamofireTest1
//
//  Created by Sergiy Lyahovchuk on 22.06.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import CoreLocation

class Location {
    var latitude: Double!
    var longitude: Double!
    
    static let sharedInstance = Location()
    
    private init() {
        print("\(self) Initialized")
    }
}
