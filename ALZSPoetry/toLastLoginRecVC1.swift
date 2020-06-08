//
//  toLastLoginRecVC1.swift
//  ALZ Poetry PoC
//
//  Created by Sreenivas Kurup on 4/1/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//
import UIKit
import AVFoundation
import WebKit

class toLastLoginRecVC1: UIViewController {
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var poemViewWeb: WKWebView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var poemTitle2: UITextField!
    
    var poemname = ""
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //---urlTextField.delegate = self
        //---poemViewWeb.navigationDelegate = self
        
        //Do any additional setup after loading the view with POEM title
        poemTitle2.text = poemname
        let urlString:String = poemname
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        poemViewWeb.load(urlRequest)
        urlTextField.text = urlString
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString:String = urlTextField.text!
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        poemViewWeb.load(urlRequest)
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if let audioRecorder = self.audioRecorder {
            if audioRecorder.isRecording {
                audioRecorder.stop()
                
                recordButton.setTitle("Record", for: .normal)
                playButton.isEnabled = true
                saveButton.isEnabled = true
                
            } else {
                audioRecorder.record()
                recordButton.setTitle("Stop", for: .normal)
                playButton.isEnabled = false
                saveButton.isEnabled = false
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
            //sound.name = poemTitle.text
            sound.name = poemTitle2.text
            if let audioURL = self.audioURL {
                sound.audioData = try? Data(contentsOf: audioURL)
                try? context.save()
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if poemViewWeb.canGoBack {
            poemViewWeb.goBack()
        }
    }
    

    @IBAction func forwardButtonTapped(_ sender: Any) {
        if poemViewWeb.canGoForward {
            poemViewWeb.goForward()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = poemViewWeb.canGoBack
        forwardButton.isEnabled = poemViewWeb.canGoForward
        urlTextField.text = poemViewWeb.url?.absoluteString
    }
    
   

}
