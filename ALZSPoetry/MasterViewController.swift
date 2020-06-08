//
//  MasterViewController.swift
//  ALZ Poetry PoC
//
//  Created by Meera Kurup on 3/20/18.
//

import UIKit
import AWSAuthCore
import AWSAuthUI
import AWSUserPoolsSignIn

class MasterViewController: UIViewController {


    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        sideMenus()

        // Do any additional setup after loading the view.
        if (AWSSignInManager.sharedInstance().isLoggedIn) {
            AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sideMenus() {
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth=200
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes=[kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
        
    }
    

}
