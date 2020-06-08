//
//  MenuTableViewController.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 2/25/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI


class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name("ToggleMenu"), object: nil)
        
        switch indexPath.row {
        case 0:
            NotificationCenter.default.post(name: Notification.Name("PlayPoems"), object: nil)
            break
        case 1:
            NotificationCenter.default.post(name: Notification.Name("Poems"), object: nil)
            break
        case 2:
            NotificationCenter.default.post(name: Notification.Name("SignOut"), object: nil)
            break
        case 3:
            NotificationCenter.default.post(name: Notification.Name("SignIn"), object: nil)
            break
        default:
            break
        }
    }
}
