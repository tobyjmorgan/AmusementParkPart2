//
//  DataEntryPolicy.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/21/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

struct DataEntryPolicy {
    
    enum labelAndTextFieldTags: Int {
        case none
        case dateOfBirth
        case ssn
        case projectNumber
        case firstName
        case lastName
        case company
        case streetAddress
        case city
        case state
        case zipCode
    }
    
    let enabled: [labelAndTextFieldTags]
}
