//
//  Mneu2VC.swift
//  ALZ Poetry PoC
//
//  Created by Sreenivas Kurup on 3/31/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//
import UIKit
import AWSAuthCore
import AWSAuthUI
import AWSUserPoolsSignIn

class Mneu2VC: UIViewController {
    fileprivate let loginButton: UIBarButtonItem = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
    

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        let userNm = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
        self.userName.text = userNm
        

        if !AWSSignInManager.sharedInstance().isLoggedIn {
            presentAuthUIViewController()
        }
    
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
    
    func presentAuthUIViewController() {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true
        config.canCancel = false
        
        AWSAuthUIViewController.presentViewController(
            with: self.navigationController!,
            configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error == nil {
                    // SignIn succeeded.
                    let userNm = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
                    self.userName.text = userNm
                } else {
                    // end user faced error while loggin in, take any required action here.
                }
        })
    }
 
/*
 
 
 class ViewController: UIViewController {
 fileprivate let loginButton: UIBarButtonItem = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
 
 @IBOutlet weak var leadingC: NSLayoutConstraint!
 @IBOutlet weak var ubeView: UIView!
 
 
 @IBOutlet weak var userName: UILabel!
 var menuIsVisible = false
 
 override func viewDidLoad() {
 super.viewDidLoad()
 customizeNavBar()
 
 NotificationCenter.default.addObserver(self, selector: #selector(self.toggleMenu(notification:)), name: Notification.Name("ToggleMenu"), object: nil)
 
 NotificationCenter.default.addObserver(self, selector: #selector(self.playPoemsNotification(notification:)), name: Notification.Name("PlayPoems"), object: nil)
 
 NotificationCenter.default.addObserver(self, selector: #selector(self.poemsNotification(notification:)), name: Notification.Name("Poems"), object: nil)
 
 NotificationCenter.default.addObserver(self, selector: #selector(self.signOutNotification(notification:)), name: Notification.Name("SignOut"), object: nil)
 
 if !AWSSignInManager.sharedInstance().isLoggedIn {
 presentAuthUIViewController()
 }
 
 }
 
 
 func presentAuthUIViewController() {
 let config = AWSAuthUIConfiguration()
 config.enableUserPoolsUI = true
 config.canCancel = false
 
 AWSAuthUIViewController.presentViewController(
 with: self.navigationController!,
 configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
 if error == nil {
 // SignIn succeeded.
 let userNm = AWSCognitoUserPoolsSignInProvider.sharedInstance().getUserPool().currentUser()?.username
 self.userName.text = userNm
 } else {
 // end user faced error while loggin in, take any required action here.
 }
 })
 }
 
 @IBAction func menuTapped(_ sender: Any) {
 NotificationCenter.default.post(name: Notification.Name("ToggleMenu"), object: nil)
 }
 
 @objc func toggleMenu(notification: Notification? = nil) {
 if menuIsVisible {
 leadingC.constant = 0
 menuIsVisible = false
 }
 else {
 leadingC.constant = 150
 menuIsVisible = true
 }
 
 UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
 self.view.layoutIfNeeded()
 })
 }
 
 @objc func playPoemsNotification(notification: Notification){
 performSegue(withIdentifier: "PlayPoems", sender: nil)
 }
 
 @objc func poemsNotification(notification: Notification){
 performSegue(withIdentifier: "Poems", sender: nil)
 }
 
 @objc func signInNotification(notification: Notification){
 if !AWSSignInManager.sharedInstance().isLoggedIn {
 presentAuthUIViewController()
 }
 }
 
 @objc func signOutNotification(notification: Notification){
 if (AWSSignInManager.sharedInstance().isLoggedIn) {
 AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
 //self.navigationController!.popToRootViewController(animated: false)
 })
 }
 performSegue(withIdentifier: "backtoMain", sender: nil)
 //self.presentAuthUIViewController()
 }
 
 
 func customizeNavBar(){
 navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 255/255 , green: 255/255, blue: 255/255, alpha: 1)
 navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 255/255, green: 87/255, blue: 35/255, alpha: 1)
 navigationController?.navigationBar.titleTextAttributes=[kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
 }
 
 }
 
*/
    
}
