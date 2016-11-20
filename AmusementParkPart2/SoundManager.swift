//
//  SoundManager.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundManager {
    
    class Notifications {
        // create constants for notifications
        static let notificationPlayDingSound = "notificationPlayDingSound"
        static let notificationPlayBuzzSound = "notificationPlayBuzzSound"
    }
    
    // sounds
    var dingSound: SystemSoundID = 0
    var buzzSound: SystemSoundID = 0
    
    init() {
        loadSounds()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playDingSound), name: NSNotification.Name(rawValue: SoundManager.Notifications.notificationPlayDingSound), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playBuzzSound), name: NSNotification.Name(rawValue: SoundManager.Notifications.notificationPlayBuzzSound), object: nil)
    }
    
    // load the specified sound
    func loadSound(filename: String, systemSound: inout SystemSoundID) {
        
        if let pathToSoundFile = Bundle.main.path(forResource: filename, ofType: "wav") {
            
            let soundURL = URL(fileURLWithPath: pathToSoundFile)
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &systemSound)
        }
    }
    
    // load all needed sounds
    func loadSounds() {
        
        loadSound(filename: "AccessGranted", systemSound: &dingSound)
        loadSound(filename: "AccessDenied", systemSound: &buzzSound)
    }
    
    @objc func playDingSound() {
        AudioServicesPlaySystemSound(dingSound)
    }
    
    @objc func playBuzzSound() {
        AudioServicesPlaySystemSound(buzzSound)
    }
}
