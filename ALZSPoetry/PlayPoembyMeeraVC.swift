//
//  PlayPoembyMeeraVC.swift
//  ALZ Poetry PoC
//
//  Created by Sreenivas Kurup on 3/24/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit
import AVFoundation


class PlayPoembyMeeraVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var messageTableView2: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var sounds : [Sound] = []
    var audioPlayer : AVAudioPlayer?
    var p: Int!
    //var poems = ["I Wandered Lonely as a Cloud","Trees","How Do I Love Thee by Elizabeth Barrett Browning"]
    
    var poems = ["It Couldn't Be Done","When You Are Old","Trees","How Do I Love Thee?","The Tyger", "Stopping by Woods on a Snowy Evening","The Arrow and the Song","Daffodils", "The Road Not Taken", "My Shadow"]
    
    var poems_urls = ["https://www.poetryfoundation.org","https://www.poets.org","https://www.poetryoutloud.org","https://www.poemhunter.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        sideMenus()
        p = 1
        messageTableView2.delegate = self
        messageTableView2.dataSource = self
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        p = sender.selectedSegmentIndex
        audioPlayer?.stop()
        messageTableView2.reloadData()
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes=[kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth=200
            revealViewController().rightViewRevealWidth=20
            //alertButton.target = revealViewController()
            //alertButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSounds()
    }
    
    //Fill Arrary with poems recorded
    func getSounds(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let tempSounds = try? context.fetch(Sound.fetchRequest()) as? [Sound] {
                if let theSounds = tempSounds {
                    sounds = theSounds
                    messageTableView2.reloadData()
                }
            }
        }
    }
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (p == 0) {
            return sounds.count
        }
        else if (p == 1)  {
            return poems.count
        }
        else if (p == 2)  {
            return poems_urls.count
        }
        else
        {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        if (p == 0) {
            let sound = sounds[indexPath.row]
            cell.poemTitle.text = sound.name
            //let sound_name = sound.name
        } else if (p == 1 ){
            cell.poemTitle.text = poems[indexPath.row]
        } else if (p == 2 ){
            cell.poemTitle.text = poems_urls[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (p == 0) {
            let sound = sounds[indexPath.row]
            if let audioData = sound.audioData {
                audioPlayer = try? AVAudioPlayer(data: audioData)
                audioPlayer?.play()
            }
            messageTableView2.deselectRow(at: indexPath, animated: true)
        }
        if (p == 1) {
            let local_poem = poems[indexPath.row]
            performSegue(withIdentifier: "toHighlightViewM", sender: local_poem)
        }
        if (p == 2) {
            let local_poem = poems_urls[indexPath.row]
            performSegue(withIdentifier: "toLastLoginRecM", sender: local_poem)
        }
    }
    
    //Prepare Segue to the Highlight view controller to Record a poem
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (p == 1) {
            let poemnameVC = segue.destination as! RecordPlayLocallyfromList
            poemnameVC.poemname = sender as! String
        } else if (p == 2) {
            let poemnameVC = segue.destination as! toLastLoginRecVC1
            poemnameVC.poemname = sender as! String
        }
    }
    
    
}
