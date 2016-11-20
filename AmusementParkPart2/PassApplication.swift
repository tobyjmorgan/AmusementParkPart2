//
//  PassApplication.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// a struct to capture the applicants personal information
// all optionals since none of these properties are mandatory
// across the different entrant types
struct ApplicantDetails {
    var firstName: String?
    var lastName: String?
    var dateOfBirth: Date?
    var street: String?
    var city: String?
    var state: String?
    var zipCode: Int?
}

// enumeration to capture each type of guest
enum GuestType {
    case classic
    case vip
    case freeChild
}

// enumeration to capture each type of employee
enum EmployeeType {
    case hourlyFoodServices
    case hourlyRideServices
    case hourlyMaintenance
}

// enumeration to capture the different entrant types
enum EntrantType {
    case guest(GuestType)
    case employee(EmployeeType)
    case manager
}
