//
//  CompaniesAndProjects.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/21/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// all available project numbers for contract employees
enum ProjectNumber: Int {
    case _1001 = 1001
    case _1002 = 1002
    case _1003 = 1003
    case _2001 = 2001
    case _2002 = 2002
    
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

// all available companies for vendors
enum CompanyName: String {
    case Acme = "Acme"
    case Orkin = "Orkin"
    case Fedex = "Fedex"
    case NWElectrical = "NW Electrical"
    
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
