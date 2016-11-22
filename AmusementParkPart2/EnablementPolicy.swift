//
//  EnablementPolicy.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/21/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation
import UIKit

protocol Enableable {
    var isEnabled: Bool { get set }
}

protocol Taggable {
    var tag: Int { get set }
}

protocol EnablementPolicyCompliant: Enableable, Taggable {}

extension UILabel: EnablementPolicyCompliant {}
extension UITextField: EnablementPolicyCompliant {}
extension UIButton: EnablementPolicyCompliant {}

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
