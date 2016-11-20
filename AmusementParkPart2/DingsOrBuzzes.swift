//
//  DingsOrBuzzes.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/17/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

// protocol that requires two sound playing methods
protocol DingsOrBuzzes {
    func playDingSound()
    func playBuzzSound()
}

extension DingsOrBuzzes {
    func playDingSound() {
        // sending notifications to whoever is listening for them
        // in this case it will be SoundManager
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.Notifications.notificationPlayDingSound), object: nil)
    }
    
    func playBuzzSound() {
        // sending notifications to whoever is listening for them
        // in this case it will be SoundManager
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.Notifications.notificationPlayBuzzSound), object: nil)
    }
}

