//
//  EntrantAccessRule.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/21/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

extension EntrantType {
    
    func getRideAccessPermissions() -> [AccessPermission] {
        
        switch self {
            
        case .guest(let type):
            switch type {
                
            case .classic, .freeChild:
                return [.rideAccess(.allRides), .ridePriority(.standard)]
                
            case .vip, .seasonPass, .senior:
                return [.rideAccess(.allRides), .ridePriority(.skipLines)]
            }
            
        case .employee(let type):
        
            switch type {
            
            case .contractEmployee(_):
                return []
            
            case .hourlyFoodServices, .hourlyRideServices, .hourlyMaintenance:
                return [.rideAccess(.allRides), .ridePriority(.standard)]
            }
            
        case .manager:
            return [.rideAccess(.allRides), .ridePriority(.standard)]

        case .vendor(_):
            return []
        }
    }
    
    func getDiscountAccessPermissions() -> [AccessPermission] {
        switch  self {
            
        case .guest(let type):
            switch type {
                
            case .classic, .freeChild:
                return []
                
            case .vip:
                return [.discountAccess(.food, 10), .discountAccess(.merchandise, 20)]
                
            case .seasonPass:
                return [.discountAccess(.food, 10), .discountAccess(.merchandise, 20)]
                
            case.senior:
                return [.discountAccess(.food, 10), .discountAccess(.merchandise, 10)]
                
            }
            
        case .employee(let type):
            switch type {
            case .contractEmployee(_):
                return []
            case .hourlyFoodServices, .hourlyRideServices, .hourlyMaintenance:
                return [.discountAccess(.food, 15), .discountAccess(.merchandise, 25)]
            }
            
        case .manager:
            return [.discountAccess(.food, 25), .discountAccess(.merchandise, 25)]
            
        case .vendor(_):
            return []
        }
    }
    
    func getAreaAccessPermissions() -> [AccessPermission] {
        
        switch self {
            
        case .guest(_):
            return [.areaAccess(.amusements)]
            
        case .employee(let type):
            
            switch type {
                
            case .hourlyFoodServices:
                return [.areaAccess(.amusements), .areaAccess(.kitchen)]
                
            case .hourlyRideServices:
                return [.areaAccess(.amusements), .areaAccess(.rideControl)]
                
            case .hourlyMaintenance:
                return [.areaAccess(.amusements), .areaAccess(.kitchen), .areaAccess(.rideControl), .areaAccess(.maintenance)]
                
            case .contractEmployee(let project):
                return project.getAreaAccessRulesForProjectNumber()
            }
            
        case .manager:
            return [.areaAccess(.amusements), .areaAccess(.kitchen), .areaAccess(.rideControl), .areaAccess(.maintenance), .areaAccess(.office)]
            
        case .vendor(let company, _):
            return company.getAreaAccessRulesForCompany()
            
        }
    }
}
