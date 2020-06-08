//
//  PlayViewController.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 3/9/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit
import AVFoundation
import WebKit


class PlayViewController: UIViewController {
    var poem: Poem?
    var recording: Recording?
    var audioPlayer : AVAudioPlayer?

    @IBOutlet weak var poemTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        
        //navigationItem.title = recording?._poemTitle
        poemTitle.text = recording?._poemTitle
     
        let fileURL = getFile(with: (recording?._htmlFileName)!, from: "public")
        let folderPath = Bundle.main.bundlePath
        let baseUrl = URL(fileURLWithPath: folderPath, isDirectory: true)
 
        
        do {
            let audioURL = getFile(with: (recording?._fileName)!, from: "protected")
            
            print("getFile completed")
            
            initAudioSession()
            
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL!, fileTypeHint: AVFileType.m4a.rawValue)
            audioPlayer!.prepareToPlay()
            audioPlayer?.play()
        }
        catch {
            print("Error: \(error)")
        }
        
        do {
            let htmlString = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
            webView.loadHTMLString(htmlString as String, baseURL: baseUrl)
        } catch {
            // catch error
        }
        
    }

    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes=[kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
        
    }
    

}
