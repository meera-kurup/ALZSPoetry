//
//  PoemTableViewCell.swift
//  ALZ Poetry PoC
//
//  Created by Jeesmon Jacob on 2/25/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit

class PoemTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var recordTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
