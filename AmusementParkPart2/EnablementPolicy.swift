//
//  EnablementPolicy.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/21/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation
import UIKit

// protocol that requires isEnabled property
protocol Enableable {
    var isEnabled: Bool { get set }
}

// protocol that requires tag property
protocol Taggable {
    var tag: Int { get set }
}

// groups them together in one protocol
protocol EnablementPolicyCompliant: Enableable, Taggable {}

// extend UILabel and UITextField with the protocol
// they of course already have these attributes, but we need
// to let the compiler know this so our generic method will work on both
extension UILabel: EnablementPolicyCompliant {}
extension UITextField: EnablementPolicyCompliant {}

// now here is our enablement policy
// it says: any compliant object I have whose tag is in the array
// will be set to enabled, everything else will be disabled
struct EnablementPolicy {
    
    let enabledTags: [Int]
    
    func applyPolicy<T: EnablementPolicyCompliant>(to controls: [T]) {
        
        for var control in controls {
            control.isEnabled = false
        }

        for var control in controls {
            if enabledTags.contains(control.tag) {
                
                control.isEnabled = true
            }
        }
    }
}
