//
//  EntrantType.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/22/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// N.B. In part 1 of this project I used enumerations with associated values
// for the master type -> sub type entrant relationship, and used associated values 
// for some other entrant values too e.g. vendor company name.
// However, this quickly became clunky when trying to use those enumerations for
// generating buttons with things like allValues.
// This struct approach has proven cleaner, but master->sub relationship now has to be
// explicitly managed, see getAllSubTypes() below, and data validation when generating passes.

struct EntrantType {
    
    // N.B. Going against swift 3 form here and using uppercase for case names.
    // This saves creating individual string values for every case
    
    // master types enumeration
    enum MasterType: String {
        case Guest
        case Employee
        case Manager
        case Vendor
        
        static func getAllValues() -> [MasterType] {
            return [MasterType.Guest,
                    MasterType.Employee,
                    MasterType.Manager,
                    MasterType.Vendor]
        }
        
        func getAllSubTypes() -> [SubType] {
            
            switch self {
                
            case .Guest:
                return [SubType.Child,
                        SubType.Adult,
                        SubType.Senior,
                        SubType.VIP,
                        SubType.SeasonPass]
                
            case .Employee:
                return [SubType.HourlyFoodServices,
                        SubType.HourlyRideServices,
                        SubType.HourlyMaintenance,
                        SubType.ContractEmployee]
                
            case .Manager:
                return [SubType.ShiftManager,
                        SubType.GeneralManager,
                        SubType.SeniorManager]
                
            case .Vendor:
                return [SubType.AnyVendor]
            }
        }

    }
    
    // sub types enumeration
    enum SubType: String {
        case Child
        case Adult
        case Senior
        case VIP
        case SeasonPass = "Season Pass"
        
        case HourlyFoodServices = "Food Services"
        case HourlyRideServices = "Ride Services"
        case HourlyMaintenance = "Maintenance"
        case ContractEmployee = "Contractor"
        
        case ShiftManager = "Shift Manager"
        case GeneralManager = "General Manager"
        case SeniorManager = "Senior Manager"
        
        case AnyVendor = "Any Vendor"
    }
    
    var masterType: MasterType
    var subType: SubType
}
