//
//  RecordPlayLocallyfromList.swift
//  ALZ Poetry PoC
//
//  Created by Meera Kurup on 3/25/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation


class RecordPlayLocallyfromList: UIViewController {
    
    
    @IBOutlet weak var poemViewWeb: WKWebView!
    @IBOutlet weak var poemTitle2: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var recording:Bool = false;
    var poemname = ""
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //poemViewWeb.navigationDelegate = self
        poemTitle2.text = poemname
        
        // Create Audio Session
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory (AVAudioSessionCategoryPlayAndRecord)
        try? session.overrideOutputAudioPort(.speaker)
        try? session.setActive(true)
        
        //URL to save the Audio
        if let basePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) .first {
            let pathComponents = [basePath, "audio.m4a"]
            
            if let audioURL = NSURL.fileURL(withPathComponents: pathComponents) {
                
                //Create some settings
                self.audioURL = audioURL
                var settings : [String: Any] = [:]
                settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
                settings[AVSampleRateKey] = 44100.0
                settings[AVNumberOfChannelsKey] = 2
                
                
                //Create the Audio Recorder
                audioRecorder = try? AVAudioRecorder(url: audioURL, settings: settings)
                audioRecorder?.prepareToRecord()
            }
        }
        playButton.isEnabled = false
        saveButton.isEnabled = false
    }

    //Function for WebView
    override func viewDidAppear(_ animated: Bool) {
        
        //var poems = ["I Wandered Lonely as a Cloud","Trees","The Sun Rising","Daughter", "When","Poem5","Poem6","Poem7"]
        
        //code from Jeesemon Uncle
        if  poemname == "Trees" {
            let htmlPath = Bundle.main.path(forResource: "Poem1", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        if  poemname == "When You Are Old" {
            let htmlPath = Bundle.main.path(forResource: "Poem2", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        
        if  poemname == "Daffodils" {
            let htmlPath = Bundle.main.path(forResource: "Poem8", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        
        if  poemname == "The Arrow and the Song" {
            let htmlPath = Bundle.main.path(forResource: "Poem7", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        
        if  poemname == "Stopping by Woods on a Snowy Evening" {
            let htmlPath = Bundle.main.path(forResource: "Poem6", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        
        if  poemname == "The Tyger" {
            let htmlPath = Bundle.main.path(forResource: "Poem4", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        
        if  poemname == "How Do I Love Thee?" {
            let htmlPath = Bundle.main.path(forResource: "Poem3", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        
        if  poemname == "It Couldn't Be Done" {
            let htmlPath = Bundle.main.path(forResource: "Poem5", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        
        if  poemname == "The Road Not Taken" {
            let htmlPath = Bundle.main.path(forResource: "Poem9", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
        
        if  poemname == "My Shadow" {
            let htmlPath = Bundle.main.path(forResource: "Poem10", ofType: "html")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                poemViewWeb.loadHTMLString(htmlString as String, baseURL: baseUrl)
            }
            catch {
            }
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if let audioRecorder = self.audioRecorder {
            if audioRecorder.isRecording {
                audioRecorder.stop()
                
                recordButton.setTitle("Record", for: .normal)
                playButton.isEnabled = true
                saveButton.isEnabled = true
                
                let method:String = "pause()";
                poemViewWeb.evaluateJavaScript(method) { (result, error) in
                    self.recording = !self.recording
                }
                
            } else {
                audioRecorder.record()
                recordButton.setTitle("Stop", for: .normal)
                playButton.isEnabled = false
                saveButton.isEnabled = false
                
                // Code from Jeesemon uncle
                let method:String = "record()";
                poemViewWeb.evaluateJavaScript(method) { (result, error) in
                    self.recording = !self.recording
                    // let image = self.recording ? UIImage(named: "microphone_recording") : UIImage(named: "microphone")
                    // self.recordButton.setImage(image, for: UIControlState.normal)
                }
            }
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
        if let audioURL = self.audioURL {
            audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let sound = Sound(entity: Sound.entity(), insertInto: context)
            sound.name = poemTitle2.text
            if let audioURL = self.audioURL {
                sound.audioData = try? Data(contentsOf: audioURL)
                try? context.save()
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
