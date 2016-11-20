//
//  ReswipeCheckable.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/17/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

protocol ReswipeCheckable {
    var thresholdForReswipe: TimeInterval { get }
    var lastSwipeTime: Date {get set }

    func isTryingToReswipe() -> Bool
}
