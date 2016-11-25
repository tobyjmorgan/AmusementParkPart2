//
//  EntrantAccessRule.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/21/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

extension ProjectNumber {
    
    // method returns area access permissions specific to a project number
    func getAreaAccessRulesForProjectNumber() -> [AccessPermission] {
        
        switch self {
            
        case ._1001:
            return [.areaAccess(.amusements), .areaAccess(.rideControl)]
            
        case ._1002:
            return [.areaAccess(.amusements), .areaAccess(.rideControl), .areaAccess(.maintenance)]
            
        case ._1003:
            return [.areaAccess(.amusements), .areaAccess(.rideControl), .areaAccess(.kitchen), .areaAccess(.maintenance), .areaAccess(.office)]
            
        case ._2001:
            return [.areaAccess(.office)]
            
        case ._2002:
            return [.areaAccess(.kitchen), .areaAccess(.maintenance)]
        }
    }
}

extension CompanyName {
    
    // method returns area access permissions specific to a company name
    func getAreaAccessRulesForCompany() -> [AccessPermission] {
        
        switch self {
            
        case .Acme:
            return [.areaAccess(.kitchen)]
            
        case .Orkin:
            return [.areaAccess(.amusements), .areaAccess(.rideControl), .areaAccess(.kitchen)]
            
        case .Fedex:
            return [.areaAccess(.maintenance), .areaAccess(.office)]
            
        case .NWElectrical:
            return [.areaAccess(.amusements), .areaAccess(.rideControl), .areaAccess(.kitchen), .areaAccess(.maintenance), .areaAccess(.office)]
        }
    }
}

extension EntrantType {
    
    func getRideAccessPermissions() -> [AccessPermission] {
        
        switch masterType {
            
        case .Guest:
            switch subType {
                
            case .Adult, .Child:
                return [.rideAccess(.allRides), .ridePriority(.standard)]
                
            case .VIP, .SeasonPass, .Senior:
                return [.rideAccess(.allRides), .ridePriority(.skipLines)]
                
            default:
                return []
            }
            
        case .Employee:
            
            switch subType {
                
            case .ContractEmployee:
                return []
                
            case .HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance:
                return [.rideAccess(.allRides), .ridePriority(.standard)]
                
            default:
                return []
            }
            
        case .Manager:
            return [.rideAccess(.allRides), .ridePriority(.standard)]
            
        case .Vendor:
            return []
        }
    }
    
    func getDiscountAccessPermissions() -> [AccessPermission] {
        switch  masterType {
            
        case .Guest:
            switch subType {
                
            case .Adult, .Child:
                return []
                
            case .VIP:
                return [.discountAccess(.food, 10), .discountAccess(.merchandise, 20)]
                
            case .SeasonPass:
                return [.discountAccess(.food, 10), .discountAccess(.merchandise, 20)]
                
            case.Senior:
                return [.discountAccess(.food, 10), .discountAccess(.merchandise, 10)]
                
            default:
                return []
            }
            
        case .Employee:
            switch subType {
            
            case .ContractEmployee:
                return []
            
            case .HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance:
                return [.discountAccess(.food, 15), .discountAccess(.merchandise, 25)]
            
            default:
                return []
            }
            
        case .Manager:
            return [.discountAccess(.food, 25), .discountAccess(.merchandise, 25)]
            
        case .Vendor:
            return []
        }
    }
    
    func getAreaAccessPermissions(personalDetails: PersonalDetails) -> [AccessPermission] {
        
        switch masterType {
            
        case .Guest:
            return [.areaAccess(.amusements)]
            
        case .Employee:
            
            switch subType {
                
            case .HourlyFoodServices:
                return [.areaAccess(.amusements), .areaAccess(.kitchen)]
                
            case .HourlyRideServices:
                return [.areaAccess(.amusements), .areaAccess(.rideControl)]
                
            case .HourlyMaintenance:
                return [.areaAccess(.amusements), .areaAccess(.kitchen), .areaAccess(.rideControl), .areaAccess(.maintenance)]
                
            case .ContractEmployee:
                if let project = personalDetails.projectNumber {
                    return project.getAreaAccessRulesForProjectNumber()
                } else {
                    return []
                }
                
            default:
                return []
            }
            
        case .Manager:
            return [.areaAccess(.amusements), .areaAccess(.kitchen), .areaAccess(.rideControl), .areaAccess(.maintenance), .areaAccess(.office)]
            
        case .Vendor:
            if let company = personalDetails.companyName {
                return company.getAreaAccessRulesForCompany()
            } else {
                return []
            }
        }
    }
}

