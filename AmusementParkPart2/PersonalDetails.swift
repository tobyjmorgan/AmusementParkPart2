//
//  PersonalDetails.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// a struct to capture the applicants personal information
// all optionals strings since this is the raw unvalidated
// data entry content
struct RawPersonalDetails {
    var firstName: String?
    var lastName: String?
    var dateOfBirth: String?
    var street: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var socialSecurityNumber: String?
    var companyName: String?
    var projectNumber: String?
}

// a similar struct, but here the data types are enforced
struct PersonalDetails {
    var firstName: String?
    var lastName: String?
    var dateOfBirth: Date?
    var street: String?
    var city: String?
    var state: String?
    var zipCode: Int?
    var socialSecurityNumber: String?
    var companyName: CompanyName?
    var projectNumber: ProjectNumber?
    var dateOfVisit: Date?

}
