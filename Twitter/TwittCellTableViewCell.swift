//
//  TwittCellTableViewCell.swift
//  AliTwitter
//
//  Created by Ali Ma on 2/19/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TwittCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var twittContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
