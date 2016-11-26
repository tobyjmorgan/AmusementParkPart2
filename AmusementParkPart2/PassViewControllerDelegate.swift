//
//  PassViewControllerDelegate.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/25/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

protocol PassViewControllerDelegate {
    func getCurrentPass() -> Pass?
    func onDismissPassViewController()
}
