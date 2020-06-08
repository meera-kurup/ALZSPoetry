//
//  RecordViewController.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 3/3/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation
import AWSAuthCore

class RecordViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var poemTitle: UILabel!
    var poem: Poem?
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioFileName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        
        if let poem = poem {
            //navigationItem.title = poem._title
            poemTitle.text = poem._title
            self.recordButton.isEnabled = false
            self.playButton.isEnabled = false
            self.saveButton.isEnabled = false
            
            let fileURL = getFile(with: poem._fileName!, from: "public")
            let folderPath = Bundle.main.bundlePath
            let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
            do {
                let htmlString = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
                webView.loadHTMLString(htmlString as String, baseURL: baseUrl)
                
                audioFileName = "\(UUID().uuidString).m4a"
                audioRecorder = getRecorder(with: audioFileName!)
                
                self.recordButton.isEnabled = true
            } catch {
                // catch error
            }
        }
    }

    @IBAction func onRecord(_ sender: Any) {
        print("Recording: \(audioRecorder?.isRecording ?? false)")
        
        let method:String = (audioRecorder?.isRecording)! ? "pause()" : "record()";
        
        let title = (audioRecorder?.isRecording)! ? "Record" : "Stop"
        recordButton.setTitle(title, for: UIControlState.normal)
        
        if (audioRecorder?.isRecording)! {
            audioRecorder?.stop()
            playButton.isEnabled = true
            saveButton.isEnabled = true
        }
        else {
            playButton.isEnabled = false
            saveButton.isEnabled = false
            
            audioRecorder?.record()
        }
        
        webView.evaluateJavaScript(method) { (result, error) in
        }
    }
    
    @IBAction func onSave(_ sender: Any) {
        do {
            let data: Data = try Data(contentsOf: (audioRecorder?.url)!)
            
            let recording = Recording()
            recording?._userId = AWSIdentityManager.default().identityId!
            recording?._id = UUID().uuidString
            recording?._fileName = audioFileName
            recording?._poemId = poem?._id
            recording?._poemTitle = poem?._title
            recording?._updatedAt = Date().timeIntervalSince1970 as NSNumber
            recording?._htmlFileName = poem?._fileName
            
            uploadFile(data, with: audioFileName!, to: "protected")
            saveRecording(recording!)
        }
        catch {
            print("\(error)")
        }
    }
    
    @IBAction func onPlay(_ sender: Any) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: (audioRecorder?.url)!)
            audioPlayer?.play()
        }
        catch {
            print("\(error)")
        }
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes=[kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
        
    }
    
}
