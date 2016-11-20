//
//  PassGenerator.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

class PassGenerator {
    
    // errors thrown by the PassGenerator processing
    enum PassGeneratorError: Error {
        case missingInformation(String), doesNotQualify(String)
    }
    
    // static method that returns the AccessPermissions associated with the specified EntrantType
    static func getAccessPermissions(for entrantType: EntrantType) -> [AccessPermission] {
        
        switch entrantType {
            
        case .guest(let guestType) :
            switch guestType {
            case .classic, .freeChild:
                return [.areaAccess(.amusements), .rideAccess(.allRides), .ridePriority(.standard)]
            case .vip:
                return [.areaAccess(.amusements), .rideAccess(.allRides), .ridePriority(.skipLines), .discountAccess(.food, 10), .discountAccess(.merchandise, 20)]
            }
            
        case .employee(let employeeType) :
            switch employeeType {
            case .hourlyFoodServices :
                return [.areaAccess(.amusements), .areaAccess(.kitchen), .rideAccess(.allRides), .ridePriority(.standard), .discountAccess(.food, 15), .discountAccess(.merchandise, 25)]
            case .hourlyRideServices :
                return [.areaAccess(.amusements), .areaAccess(.rideControl), .rideAccess(.allRides), .ridePriority(.standard), .discountAccess(.food, 15), .discountAccess(.merchandise, 25)]
            case .hourlyMaintenance :
                return [.areaAccess(.amusements), .areaAccess(.kitchen), .areaAccess(.rideControl), .areaAccess(.maintenance), .rideAccess(.allRides), .ridePriority(.standard), .discountAccess(.food, 15), .discountAccess(.merchandise, 25)]
            }
            
        case .manager :
            return [.areaAccess(.amusements), .areaAccess(.kitchen), .areaAccess(.rideControl), .areaAccess(.maintenance), .areaAccess(.office), .rideAccess(.allRides), .ridePriority(.standard), .discountAccess(.food, 25), .discountAccess(.merchandise, 25)]
        }
    }
    
    // static method that returns a pass based on the provided information, but throws
    // errors when certain validations are not met
    static func generatePass(applicant: ApplicantDetails, entrantType: EntrantType) throws -> Pass {
        
        switch entrantType {
            
        case .guest(let guestType) :
            
            switch guestType {
                
            case .freeChild:
                guard let dob = applicant.dateOfBirth else {
                    throw PassGeneratorError.missingInformation("Date of Birth")
                }
                
                guard Date().timeIntervalSince1970 - dob.timeIntervalSince1970 < DateHelper.getTimeInterval(numberOfYears: 5) else {
                    throw PassGeneratorError.doesNotQualify("Age exceeds maximum age for Child pass")
                }
                
            case .classic, .vip :
                // no validation required
                break
            }
            
        case .employee(_), .manager :
            guard applicant.firstName != nil else {
                throw PassGeneratorError.missingInformation("First Name")
            }
            
            guard applicant.lastName != nil else {
                throw PassGeneratorError.missingInformation("Last Name")
            }
            
            guard applicant.street != nil else {
                throw PassGeneratorError.missingInformation("Street Address")
            }
            
            guard applicant.city != nil else {
                throw PassGeneratorError.missingInformation("City")
            }
            
            guard applicant.state != nil else {
                throw PassGeneratorError.missingInformation("State")
            }
            
            guard applicant.zipCode != nil else {
                throw PassGeneratorError.missingInformation("Zip Code")
            }
        }
        
        return Pass(permissions: getAccessPermissions(for: entrantType), entrant: applicant, entrantType: entrantType)
    }
}
