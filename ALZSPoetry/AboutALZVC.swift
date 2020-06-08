//
//  AboutALZVC.swift
//  ALZ Poetry PoC
//
//  Created by Sreenivas Kurup on 3/21/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit

class AboutALZVC: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        sideMenus()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth=190
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes=[kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
        
    }

}
