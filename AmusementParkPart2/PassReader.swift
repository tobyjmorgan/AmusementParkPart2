//
//  Swipeable.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/17/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// protocol that specfies the minimum requirements of a swipe result
protocol SwipeResult {
    var permitted: Bool { get }
    var message: String { get }
}

// protocol for a PassReader - anything that can swipe a Pass
protocol PassReader {
    func swipe(pass: Pass, silent: Bool) -> SwipeResult
}

// extensions to some of our AccessPermission stuff so that they can
// swipe passes and provide results - oh and play Dings or Buzzes


extension Area: PassReader, DingsOrBuzzes {
    
    struct AreaSwipeResult: SwipeResult {
        let permitted: Bool
        let message: String
    }
    
    // this swipe is for a summary of all area access permissions
    static func swipe(pass: Pass, silent: Bool) -> SwipeResult {
        
        var message = ""
        var foundOne = false
        
        // check for birthday
        if let birthdayMessage = pass.entrant.checkBirthday() {
            message += birthdayMessage + "\n"
        }
        
        for permission in pass.permissions {
            switch permission {
            case .areaAccess(let area):
                message += "\(area.description())\n"
                foundOne = true
            default:
                break
            }
        }
        
        if foundOne {
            
            if !silent { playDingSound() }
            return AreaSwipeResult(permitted: true, message: message)
            
        } else {
            
            // did not find that permission
            if !silent { playBuzzSound() }
            return AreaSwipeResult(permitted: false, message: "No Access")
        }
    }
    
    // this swipe is for accessing a specific area
    func swipe(pass: Pass, silent: Bool) -> SwipeResult {

        // look for the permission and return the appropriate result
        for permission in pass.permissions {
            switch permission {
            case .areaAccess(let area):
                if area == self {
                    playDingSound()
                    return AreaSwipeResult(permitted: true, message: "Access Granted: please enter the \(area)")
                }
            default:
                break
            }
        }
        
        // did not find that permission
        playBuzzSound()
        return AreaSwipeResult(permitted: false, message: "Access Denied")
    }
}




extension RideAccess: PassReader, DingsOrBuzzes {
    
    struct RideAccessSwipeResult: SwipeResult {
        let permitted: Bool
        let message: String
        let priority: RidePriority?
    }
    
    // this swipe is for summary ride access and ride priority information
    static func swipe(pass: Pass, silent: Bool) -> SwipeResult {
    
        var message = ""
        var foundOne = false
        
        // guard against reswipes, but only if we are actually swiping
        // silent swipe is when we use these methods to get info for
        // display on the Pass view controller
        if !silent {
            guard !pass.isTryingToReswipe() else {
                playBuzzSound()
                return RideAccessSwipeResult(permitted: false, message: "Access Denied: : sorry, this pass has already been used recently. Please try again later.", priority: nil)
            }
        }
        
        // check for birthday
        if let birthdayMessage = pass.entrant.checkBirthday() {
            message += birthdayMessage + "\n"
        }

        for permission in pass.permissions {
            switch permission {
            case .rideAccess(let rideAccess):
                message += rideAccess.description()
                foundOne = true
            default:
                break
            }
        }
        
        for permission in pass.permissions {
            switch permission {
            case .ridePriority(let ridePriority):
                if ridePriority == .skipLines {
                    message += ", " + ridePriority.description()
                }
            default:
                break
            }
        }
        
        if foundOne {
            
            if !silent { playDingSound() }
            return RideAccessSwipeResult(permitted: true, message: message, priority: nil)
            
        } else {
            
            // did not find that permission
            if !silent { playBuzzSound() }
            return RideAccessSwipeResult(permitted: false, message: "No Access", priority: nil)
        }
    }
    
    // this swipe is for attempting to swipe at a specific ride
    func swipe(pass: Pass, silent: Bool) -> SwipeResult {
        
        guard self != .noRides else {
            return RideAccessSwipeResult(permitted: false, message: "Doesn't make sense to try to access no rides", priority: nil)
        }
        
        // guard against reswipes
        guard !pass.isTryingToReswipe() else {
            playBuzzSound()
            return RideAccessSwipeResult(permitted: false, message: "Access Denied: : sorry, this pass has already been used recently. Please try again later.", priority: nil)
        }

        var priority: RidePriority? = nil
        
        // try to get priority first
        for permission in pass.permissions {
            switch permission {
            case .ridePriority(let ridePriority):
                priority = ridePriority
            default:
                break
            }
        }
        
        // look for the permission and return the appropriate result
        for permission in pass.permissions {
            switch permission {
            case .rideAccess(let access):
                if access == self {
                    playDingSound()
                    return RideAccessSwipeResult(permitted: true, message: "Access Granted: enjoy your ride!", priority: priority)
                }
            default:
                break
            }
        }
        
        // did not find that permission
        playBuzzSound()
        return RideAccessSwipeResult(permitted: false, message: "Access Denied", priority: nil)
    }
}




extension DiscountType: PassReader, DingsOrBuzzes {
    
    struct DiscountTypeSwipeResult: SwipeResult {
        let permitted: Bool
        let message: String
        let amount: Int?
    }
    
    // this swipe is for all discount types
    static func swipe(pass: Pass, silent: Bool) -> SwipeResult {
        
        var message = ""
        var foundOne = false
        
        // check for birthday
        if let birthdayMessage = pass.entrant.checkBirthday() {
            message += birthdayMessage + "\n"
        }
        
        // look for the permission and return the appropriate result
        for permission in pass.permissions {
            switch permission {
            case .discountAccess(let discount, let amount):
                foundOne = true
                if discount == .food {
                    message += "\(amount)% Food Discount\n"
                } else if discount == .merchandise {
                    message += "\(amount)% Merchandise Discount\n"
                }
                
            default:
                break
            }
        }
        
        if foundOne {
            
            if !silent { playDingSound() }
            return DiscountTypeSwipeResult(permitted: foundOne, message: message, amount: 0)

        } else {
            
            // did not find that permission
            if !silent { playBuzzSound() }
            return DiscountTypeSwipeResult(permitted: false, message: "No Discounts", amount: nil)
        }
    }
    
    // this swipe is specific to an individual discount type
    func swipe(pass: Pass, silent: Bool) -> SwipeResult {
        
        // look for the permission and return the appropriate result
        for permission in pass.permissions {
            switch permission {
            case .discountAccess(let discount, let amount):
                if discount == self {
                    if !silent { playDingSound() }
                    return DiscountTypeSwipeResult(permitted: true, message: "Discount: \(discount) \(amount)%", amount: amount)
                }
            default:
                break
            }
        }
        
        // did not find that permission
        if !silent { playBuzzSound() }
        return DiscountTypeSwipeResult(permitted: false, message: "Sorry you do not have a \(self) discount", amount: nil)
    }
}

