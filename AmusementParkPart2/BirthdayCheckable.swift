//
//  BirthdayCheckable.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/17/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// protocol that specifies the parts needed to check birthday
protocol BirthdayCheckable {
    var firstName: String? { get }
    var dateOfBirth: Date? { get }
    func checkBirthday() -> String?
}

extension BirthdayCheckable {
 
    // display a birthday message, include the name if available
    func birthdayMessage() -> String {
        if let name = firstName {
            return "Happy Birthday \(name)!"
        } else {
            return "Happy Birthday!"
        }
    }
    
    // determine if today is the entrants birthday
    func isEntrantsBirthday() -> Bool {
        
        // can only do this check if date of birth is available
        if let dob = dateOfBirth {
            
            // get today's date
            let today = Date()
            
            // get the month and day components of the two dates
            let todayDay = Calendar.current.component(.day, from: today)
            let todayMonth = Calendar.current.component(.month, from: today)
            let dobDay = Calendar.current.component(.day, from: dob)
            let dobMonth = Calendar.current.component(.month, from: dob)
            
            if dobDay == todayDay && dobMonth == todayMonth {
                return true
            }
        }
        
        return false
    }
    
    // if its their birthday return a message
    func checkBirthday() -> String? {
        
        if isEntrantsBirthday() {
             return birthdayMessage()
        }
        
        return nil
    }
}

extension PersonalDetails: BirthdayCheckable {}
