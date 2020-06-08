//
//  CustomTableViewCell.swift
//  ALZ Poetry PoC
//
//  Created by Sreenivas Kurup on 3/24/18.
//  Copyright © 2018 Jeesmon Jacob. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var poemTitle: UILabel!

    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
