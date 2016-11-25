//
//  PopulateData.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/23/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation
import GameKit

extension EntrantType {
    
    func getPrePopulatedData() -> RawPersonalDetails {
        
        var details = RawPersonalDetails()
        
        let random = GKRandomSource.sharedRandom().nextInt(upperBound: 4)
            
        switch masterType {
        case .Guest:
            switch subType {
            case .Adult, .VIP:
                // no personal details required
                break
            case .Child:
                if random > 1 {
                    details.dateOfBirth = "11/30/2011"
                } else {
                    details.dateOfBirth = "11/20/2011"
                }
            case .Senior:
                if random > 1 {
                    details.firstName = "Albert"
                    details.lastName = "Too-Young"
                    details.dateOfBirth = "11/30/1956"
                } else {
                    details.firstName = "John"
                    details.lastName = "Old-Enough"
                    details.dateOfBirth = "11/20/1956"
                }
            case .SeasonPass:
                if random > 1 {
                    details.firstName = "Ridey"
                    details.lastName = "McRide"
                    details.street = "10 Ride Road"
                    details.city = "Ridesville"
                    details.state = "CA"
                    details.zipCode = "90210"
                    details.dateOfBirth = "01/01/2001"
                } else {
                    details.firstName = "Frank"
                    details.lastName = "Bruno"
                    details.street = "9 Punching Bag Lane"
                    details.city = "Knoxville"
                    details.state = "State Too Long"
                    details.zipCode = "77777"
                    details.dateOfBirth = "02/02/2002"
                }
            default:
                break
            }
        case .Employee:
            switch subType {
            case .HourlyFoodServices, .HourlyRideServices, .HourlyMaintenance:
                if random > 1 {
                    details.firstName = "Bears"
                    details.lastName = "Fan"
                    details.street = "42 State Street"
                    details.city = "Chicago"
                    details.state = "IL"
                    details.zipCode = "60611"
                    details.dateOfBirth = "03/03/1980"
                    details.socialSecurityNumber = "111-22-3333"
                } else {
                    details.firstName = "Packers"
                    details.lastName = "Supporter"
                    details.street = "67 Main Street"
                    details.city = "Greenbay"
                    details.state = "WI"
                    details.zipCode = "50453"
                    details.dateOfBirth = "04/04/1984"
                    details.socialSecurityNumber = "222-33-4444"
                }
            case .ContractEmployee:
                if random == 0 {
                    details.firstName = "Lions"
                    details.lastName = "Nut"
                    details.street = "22 Everyday Lane"
                    details.city = "Detroit"
                    details.state = "MI"
                    details.zipCode = "40143"
                    details.dateOfBirth = "05/05/1985"
                    details.socialSecurityNumber = "333-44-5555"
                    details.projectNumber = "1001"
                } else if random == 1 {
                    details.firstName = "Jets"
                    details.lastName = "Sucker"
                    details.street = "88 Loser Ave"
                    details.city = "New York"
                    details.state = "NY"
                    details.zipCode = "11111"
                    details.dateOfBirth = "06/06/1986"
                    details.socialSecurityNumber = "444-55-6666"
                    details.projectNumber = "Bad Project Number"
                } else  {
                    details.firstName = "Bengals"
                    details.lastName = "Boy"
                    details.street = "44 Blah Ave"
                    details.city = "New York"
                    details.state = "NY"
                    details.zipCode = "11111"
                    details.dateOfBirth = "06/06/1986"
                    details.socialSecurityNumber = "444-55-6666"
                    details.projectNumber = "2002"
                }
            default:
                break
            }
        case .Manager:
            if random > 1 {
                details.firstName = "Leader"
                details.lastName = "McBossyPants"
                details.street = "100 Corporate Road"
                details.city = "Seattle"
                details.state = "WA"
                details.zipCode = "32902"
                details.dateOfBirth = "06/06/1986"
                details.socialSecurityNumber = "555-66-7777"
            } else {
                details.firstName = "Napolean"
                details.lastName = "Complex"
                details.street = "99 Bonaparte Road"
                details.city = "Portland"
                details.state = "OR"
                details.zipCode = "22222"
                details.dateOfBirth = "07/07/1987"
                details.socialSecurityNumber = "777-77-7777"
            }
        case .Vendor:
            if random == 0 {
                details.firstName = "Extremely long name to test long names"
                details.lastName = "Dracula"
                details.companyName = "Acme"
                details.dateOfBirth = "12/12/1990"
            } else if random == 1 {
                details.firstName = "Larry"
                details.lastName = "Leech"
                details.companyName = "Fedex"
                details.dateOfBirth = "10/10/1995"
            } else {
                details.firstName = "Bad"
                details.lastName = "Company"
                details.companyName = "Koch Industries"
                details.dateOfBirth = "10/10/1925"
            }
        }
        
        return details
    }
}
