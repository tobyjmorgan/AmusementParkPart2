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
    
    // static method that returns a pass based on the provided information, but throws
    // errors when certain validations are not met
    static func generatePass(applicant: PersonalDetails, entrantType: EntrantType) throws -> Pass {
        
        switch entrantType {
            
        case .guest(let guestType) :
            
            switch guestType {
                
            case .classic, .vip :
                // no validation required
                break
            
            case .freeChild:
                
                guard let dob = applicant.dateOfBirth else {
                    throw PassGeneratorError.missingInformation("Date of Birth")
                }
                
                guard Date().timeIntervalSince1970 - dob.timeIntervalSince1970 < DateHelper.getTimeInterval(numberOfYears: 5) else {
                    throw PassGeneratorError.doesNotQualify("Age exceeds maximum age for Child pass")
                }
            
            case .seasonPass:
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
                
                guard applicant.dateOfBirth != nil else {
                    throw PassGeneratorError.missingInformation("Date of Birth")
                }
                
            case .senior:
                
                guard applicant.firstName != nil else {
                    throw PassGeneratorError.missingInformation("First Name")
                }
                
                guard applicant.lastName != nil else {
                    throw PassGeneratorError.missingInformation("Last Name")
                }
                
                guard let dob = applicant.dateOfBirth else {
                    throw PassGeneratorError.missingInformation("Date of Birth")
                }
                
                // N.B. no minimum age was specified to qualify for a senior pass
                // but assumed it would be 60 and added validation for that
                guard Date().timeIntervalSince1970 - dob.timeIntervalSince1970 > DateHelper.getTimeInterval(numberOfYears: 60) else {
                    throw PassGeneratorError.doesNotQualify("Age exceeds minimum age for Senior pass")
                }
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
            
            guard applicant.socialSecurityNumber != nil else {
                throw PassGeneratorError.missingInformation("Social Security Number")
            }
            
            guard applicant.dateOfBirth != nil else {
                throw PassGeneratorError.missingInformation("Date of Birth")
            }
            
            // N.B. for contract type employee project number is an associated value
            // so is validated before call to pass generation
            
        case .vendor(_) :
            guard applicant.firstName != nil else {
                throw PassGeneratorError.missingInformation("First Name")
            }
            
            guard applicant.lastName != nil else {
                throw PassGeneratorError.missingInformation("Last Name")
            }
            
            guard applicant.dateOfBirth != nil else {
                throw PassGeneratorError.missingInformation("Date of Birth")
            }
            
            // N.B. company and date of visit are associated values of vendor entrant type
            // so are validated before call to pass generation
        }
        
        let permissions = entrantType.getAreaAccessPermissions() + entrantType.getRideAccessPermissions() + entrantType.getDiscountAccessPermissions()
        
        return Pass(permissions: permissions, entrant: applicant, entrantType: entrantType)
    }
}
