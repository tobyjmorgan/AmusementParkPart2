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
struct PersonalDetails {
    var firstName: String?
    var lastName: String?
    var dateOfBirth: Date?
    var street: String?
    var city: String?
    var state: String?
    var zipCode: Int?
    var socialSecurityNumber: Int?
}

// enumeration to capture each type of guest
enum GuestType {
    case classic
    case vip
    case freeChild
    case seasonPass
    case senior
}

// enumeration to capture each type of employee
enum EmployeeType {
    case hourlyFoodServices
    case hourlyRideServices
    case hourlyMaintenance
    case contractEmployee(ProjectNumber)
}

// enumeration to capture each type of manager
enum ManagerType {
    case shiftManager
    case generalManager
    case seniorManager
}

// enumeration to capture the different entrant types
enum EntrantType {
    case guest(GuestType)
    case employee(EmployeeType)
    case manager(ManagerType)
    case vendor(CompanyName, Date)
}
