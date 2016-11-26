//
//  Describable.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// protocol that forces anything adopting it to be able to return
// a String representing its details
protocol Describable {
    func description() -> String
}

// extending our AccessPermission enumeration to conform to
// the Describable protocol
extension AccessPermission: Describable {
    func description() -> String {
        switch self {
        case .areaAccess(let area):
            return "Area Access: \(area)"
        case .rideAccess(let access):
            return "Ride Access: \(access)"
        case .ridePriority(let priority):
            return "Ride Priority: \(priority)"
        case .discountAccess(let discount, let amount):
            return "Discount: \(discount) \(amount)%"
        }
    }
}

extension RideAccess: Describable {
    func description() -> String {
        switch self {
        case .allRides:
            return "Unlimited Rides"
        case .noRides:
            return "No Ride Access"
        }
    }
}

extension RidePriority: Describable {
    func description() -> String {
        switch self {
        case .standard:
            return ""
        case .skipLines:
            return "Skip Lines"
        }
    }
}

extension Area: Describable {
    func description() -> String {
        switch self {
        case .amusements:
            return "Amusements"
        case .kitchen:
            return "Kitchen"
        case .rideControl:
            return "Ride Control"
        case .maintenance:
            return "Maintenance"
        case .office:
            return "Office"
        }
    }
}

// extending Pass so that it can describe itself too
extension Pass: Describable {
    func description() -> String {
        
        var returnString: String = ""
        
        for permission in permissions {
            returnString += permission.description() + "\n"
        }
        
        return returnString
    }
}

extension EntrantType: Describable {
    func description() -> String {
        switch masterType {
        case .Guest:
            switch subType {
            case .Adult:
                return "Adult Guest"
            case .Child:
                return "Child Guest"
            case .VIP:
                return "VIP Guest"
            case .Senior:
                return "Senior Guest"
            case .SeasonPass:
                return "Season"
            default:
                return ""
            }
        case .Employee:
            switch subType {
            case .HourlyFoodServices:
                return "Food Services Employee"
            case .HourlyRideServices:
                return "Ride Services Employee"
            case .HourlyMaintenance:
                return "Maintenance Employee"
            case .ContractEmployee:
                return "Contract Employee"
            default:
                return ""
            }
        case .Manager:
            switch subType {
            case .GeneralManager:
                return "General Manager"
            case .ShiftManager:
                return "Shift Manager"
            case .SeniorManager:
                return "Senior Manager"
            default:
                return ""
            }
        case .Vendor:
            return "Vendor"
        }
    }
}
