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
        case missingInformation(String), invalidInformation(String), doesNotQualify(String), entrantSubTypeDoesNotRelateToMasterType
    }
    
    // static method that returns a pass based on the provided information, but throws
    // errors when certain validations are not met
    static func generatePass(applicant: RawPersonalDetails, entrantType: EntrantType) throws -> Pass {
        
        // tries to unwrap the value and checks if it is an empty string
        // returns bool based on success
        func isValuePresent(string: String?) -> Bool {
            guard let value = string,
                value != "" else {
                return false
            }
            
            return true
        }
        
        // tries to unwrap the value and checks if it is an empty string
        // returns the actual value if successful and nil if not
        func getValue(string: String?) -> String? {
            guard let value = string,
                value != "" else {
                return nil
            }
            
            return value
        }
        
        // create a target PersonalDetails object ready for values to be assigned to
        var details = PersonalDetails()
        
        // look up what data entry field groups are required by this entrant type
        let requiredGroups = entrantType.getRequiredFieldGroups()
        
        // iterate through the groups
        for group in requiredGroups {
            
            switch group {
            
            case .name:
                guard isValuePresent(string: applicant.firstName) else {
                    throw PassGeneratorError.missingInformation("First Name")
                }
                
                guard isValuePresent(string: applicant.lastName) else {
                    throw PassGeneratorError.missingInformation("Last Name")
                }
            
                details.firstName = applicant.firstName
                details.lastName = applicant.lastName

            case .address:
                guard isValuePresent(string: applicant.street) else {
                    throw PassGeneratorError.missingInformation("Street Address")
                }
                
                guard isValuePresent(string: applicant.city) else {
                    throw PassGeneratorError.missingInformation("City")
                }
                
                guard isValuePresent(string: applicant.state) else {
                    throw PassGeneratorError.missingInformation("State")
                }
                
                guard isValuePresent(string: applicant.zipCode) else {
                    throw PassGeneratorError.missingInformation("Zip Code")
                }

                details.street = applicant.street
                details.city = applicant.city
                details.state = applicant.state
                details.zipCode = applicant.zipCode
               
            case .dob:
                guard let dobString = getValue(string: applicant.dateOfBirth) else {
                    throw PassGeneratorError.missingInformation("Date of Birth")
                }
                
                guard let dob = DateHelper.getDateFromStringMM_DD_YYYY(stringDate: dobString) else {
                    throw PassGeneratorError.invalidInformation("Date of Birth: \(dobString)")
                }
                
                // extra validation on age
                if entrantType.masterType == .Guest && entrantType.subType == .Child {
                    
                    guard Date().timeIntervalSince1970 - dob.timeIntervalSince1970 < DateHelper.getTimeInterval(numberOfYears: 5) else {
                        throw PassGeneratorError.doesNotQualify("Age exceeds maximum age for Child pass")
                    }
                }
                
                if entrantType.masterType == .Guest && entrantType.subType == .Senior {
                    
                    // N.B. no minimum age was specified to qualify for a senior pass
                    // but assumed it would be 60 and included validation for that
                    guard Date().timeIntervalSince1970 - dob.timeIntervalSince1970 > DateHelper.getTimeInterval(numberOfYears: 60) else {
                        throw PassGeneratorError.doesNotQualify("Must be 60 or older to qualify for a Senior pass.")
                    }
                }
                
                details.dateOfBirth = dob

            case .ssn:
                guard isValuePresent(string: applicant.socialSecurityNumber) else {
                    throw PassGeneratorError.missingInformation("Social Security Number")
                }
                
                details.socialSecurityNumber = applicant.socialSecurityNumber

            case .project:
                guard let projectString = getValue(string:applicant.projectNumber) else {
                    throw PassGeneratorError.missingInformation("Project Number")
                }
                
                guard let projectInt = Int(projectString),
                    let project = ProjectNumber(rawValue: projectInt) else {
                        throw PassGeneratorError.invalidInformation("Project Number")
                }
                
                details.projectNumber = project
                
            case .company:
                guard let companyString = getValue(string: applicant.companyName) else {
                    throw PassGeneratorError.missingInformation("Company Name")
                }
                
                guard let company = CompanyName(rawValue: companyString) else {
                    throw PassGeneratorError.invalidInformation("Company Name")
                }
                
                details.companyName = company
            }
        }
        
        // if this is a vendor then automatically set the date of visit
        if entrantType.masterType == .Vendor {
            details.dateOfVisit = Date()
        }
        
        let permissions = entrantType.getAreaAccessPermissions(personalDetails: details) + entrantType.getRideAccessPermissions() + entrantType.getDiscountAccessPermissions()
        
        return Pass(permissions: permissions, entrant: details, entrantType: entrantType)
    }
}
