//
//  TrackCell.swift
//  FungjaiTest
//
//  Created by Admin on 7/16/2560 BE.
//  Copyright © 2560 Admin. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet var lbName: UILabel!
    @IBOutlet var ivCover: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
