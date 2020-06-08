//
//  PoemTableViewCell2.swift
//  ALZ Poetry PoC
//
//  Created by Meera Kurup on 3/24/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit

class PoemTableViewCell2: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var recordTitle: UIButton!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
