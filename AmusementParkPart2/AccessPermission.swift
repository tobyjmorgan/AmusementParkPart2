//
//  AccessPermission.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// enumeration that captures all of the possible areas that can be
// accessed as part of Area Access
enum Area {
    case amusements
    case kitchen
    case rideControl
    case maintenance
    case office
}

// enumeration that captures the ride priority associated with 
// Ride Access
enum RidePriority {
    case standard
    case skipLines
}

// enumeration that captures access to rides
enum RideAccess {
    case noRides
    case allRides
    // could be specific rides or groups of rides added in future
}

// enumeration that captures the currently available types
// of discount for Discount Access
enum DiscountType {
    case food
    case merchandise
}

// enumeration that captures the available types of access
enum AccessPermission {
    case areaAccess(Area)
    case rideAccess(RideAccess)
    case ridePriority(RidePriority)
    case discountAccess(DiscountType, Int)
}
