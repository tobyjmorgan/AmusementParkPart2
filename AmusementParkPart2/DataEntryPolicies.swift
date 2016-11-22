//
//  DataEntryPolicies.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/21/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

enum DataEntryTag: Int {
    case dateOfBirth = 1
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

extension EntrantType {
    
    func getEnablementPolicy() -> EnablementPolicy {
        
        
        let dateOfBirthFields = [DataEntryTag.dateOfBirth.rawValue]
        let nameFields = [DataEntryTag.firstName.rawValue, DataEntryTag.lastName.rawValue]
        let addressFields = [DataEntryTag.streetAddress.rawValue, DataEntryTag.city.rawValue, DataEntryTag.state.rawValue, DataEntryTag.zipCode.rawValue]
        let ssnFields = [DataEntryTag.ssn.rawValue]
        
        switch self {
            
        case .guest(let type):
            switch type {
            case .classic, .vip:
                return EnablementPolicy(enabledTags: [])
            case .freeChild:
                return EnablementPolicy(enabledTags: dateOfBirthFields)
            case .seasonPass:
                return EnablementPolicy(enabledTags: nameFields + addressFields + dateOfBirthFields)
            case .senior:
                return EnablementPolicy(enabledTags: nameFields + dateOfBirthFields)
            }
            
        case .employee(let type):
            switch type {
            case .hourlyFoodServices, .hourlyRideServices, .hourlyMaintenance:
                return EnablementPolicy(enabledTags: nameFields + addressFields + dateOfBirthFields)
            case .contractEmployee(_):
                return EnablementPolicy(enabledTags: nameFields + addressFields + dateOfBirthFields + ssnFields)
            }
            
        case .manager:
            return EnablementPolicy(enabledTags: nameFields + addressFields + dateOfBirthFields + ssnFields)
            
        case .vendor(_):
            return EnablementPolicy(enabledTags: nameFields + dateOfBirthFields)
            
        }
    }
}

