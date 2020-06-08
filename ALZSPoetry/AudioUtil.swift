//
//  AudioUtil.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 3/4/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import Foundation
import AVFoundation

func getRecorder(with name: String) -> AVAudioRecorder? {
    // Create Audio Session
    let session = AVAudioSession.sharedInstance()
    try? session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    try? session.setActive(true)
    
    //URL to save the Audio
    if let audioURL = getURL(with: name) {
        //Create some settings
        var settings : [String: Any] = [:]
        settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
        settings[AVSampleRateKey] = 44100.0
        settings[AVNumberOfChannelsKey] = 2
        
        
        //Create the Audio Recorder
        let audioRecorder = try? AVAudioRecorder(url: audioURL, settings: settings)
        
        return audioRecorder
    }
    
    return nil
}

func initAudioSession() {
    let session = AVAudioSession.sharedInstance()
    try? session.setCategory(AVAudioSessionCategoryPlayback)
    try? session.setActive(true)
    
    //Create some settings
    var settings : [String: Any] = [:]
    settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
    settings[AVSampleRateKey] = 44100.0
    settings[AVNumberOfChannelsKey] = 2
}
