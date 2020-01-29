//
//  MemeTableViewCell.swift
//  Meme Me
//
//  Created by Claudia Contreras on 1/28/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var savedMemeImage: UIImageView!
    @IBOutlet weak var savedMemeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        savedMemeLabel.text = " "
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
