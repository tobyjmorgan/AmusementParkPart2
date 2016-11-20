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
    func swipe(pass: Pass) -> SwipeResult
}

// extensions to some of our AccessPermission stuff so that they can
// swipe passes and provide results - oh and play Dings or Buzzes


extension Area: PassReader, DingsOrBuzzes {
    
    struct AreaSwipeResult: SwipeResult {
        let permitted: Bool
        let message: String
    }
    
    func swipe(pass: Pass) -> SwipeResult {

        // check for birthday
        pass.entrant.checkBirthday()
        
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
    
    func swipe(pass: Pass) -> SwipeResult {
        
        guard self != .noRides else {
            return RideAccessSwipeResult(permitted: false, message: "Doesn't make sense to try to access no rides", priority: nil)
        }
        
        // check for birthday
        pass.entrant.checkBirthday()
        
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
    
    func swipe(pass: Pass) -> SwipeResult {
        
        // check for birthday
        pass.entrant.checkBirthday()
        
        // look for the permission and return the appropriate result
        for permission in pass.permissions {
            switch permission {
            case .discountAccess(let discount, let amount):
                if discount == self {
                    playDingSound()
                    return DiscountTypeSwipeResult(permitted: true, message: "Discount: \(discount) \(amount)%", amount: amount)
                }
            default:
                break
            }
        }
        
        // did not find that permission
        playBuzzSound()
        return DiscountTypeSwipeResult(permitted: false, message: "Sorry you do not have a \(self) discount", amount: nil)
    }
}

