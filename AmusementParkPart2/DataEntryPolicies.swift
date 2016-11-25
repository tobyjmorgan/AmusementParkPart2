//
//  DataEntryPolicies.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/21/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// enumeration to capture all the different data entry fields
// the numerical tag corresponds to the tag used in Interface Builder
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

// grouping the required fields in to groups
enum RequiredFieldGroup {
    case name
    case address
    case ssn
    case dob
    case project
    case company
}

// each group can now return its member fields' tags
extension RequiredFieldGroup {
    func getRequiredDataEntryTags() -> [Int] {
        switch self {
        case .name:
            return [DataEntryTag.firstName.rawValue, DataEntryTag.lastName.rawValue]
        case .address:
            return [DataEntryTag.streetAddress.rawValue, DataEntryTag.city.rawValue, DataEntryTag.state.rawValue, DataEntryTag.zipCode.rawValue]
        case .dob:
            return [DataEntryTag.dateOfBirth.rawValue]
        case .ssn:
            return [DataEntryTag.ssn.rawValue]
        case .project:
            return [DataEntryTag.projectNumber.rawValue]
        case .company:
            return [DataEntryTag.company.rawValue]
        }
    }
}

// extend EntrantType to return the groups of required fields
// and to return an data entry enablement policy
extension EntrantType {
    
    func getRequiredFieldGroups() -> [RequiredFieldGroup] {
        
        switch masterType {
            
        case .Guest:
            switch subType {
            case .Adult, .VIP:
                return []
            case .Child:
                return [.dob]
            case .SeasonPass:
                return [.name, .address, .dob]
            case .Senior:
                return [.name, .dob]
            default:
                return []
            }
            
        case .Employee:
            switch subType {
            case .HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance:
                return [.name, .address, .dob, .ssn]
            case .ContractEmployee:
                return [.name, .address, .dob, .ssn, .project]
            default:
                return []
            }
            
        case .Manager:
            return [.name, .address, .dob, .ssn]
            
        case .Vendor:
            return [.name, .dob, .company]
        }
    }
    
    func getEnablementPolicy() -> EnablementPolicy {
        
        var tags: [Int] = []
        
        // gather up all the tags from all the member groups
        for group in self.getRequiredFieldGroups() {
            tags += group.getRequiredDataEntryTags()
        }
        
        return EnablementPolicy(enabledTags:tags)
    }
}

