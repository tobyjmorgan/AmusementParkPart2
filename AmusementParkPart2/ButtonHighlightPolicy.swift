//
//  ButtonHighlightPolicy.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/22/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation
import UIKit

// quick way of applying color highlighting to buttons
struct ButtonHighlightPolicy {
    
    let highlightColor: UIColor
    let unhighlightColor: UIColor
    
    func applyHighlightTo(buttons: [UIButton]) {
        
        for button in buttons {
            button.setTitleColor(highlightColor, for: .normal)
        }
    }

    func applyUnhighlightTo(buttons: [UIButton]) {
        
        for button in buttons {
            button.setTitleColor(unhighlightColor, for: .normal)
        }
    }
}
