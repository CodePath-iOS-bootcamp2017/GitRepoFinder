//
//  LanguagesTableViewCell.swift
//  GithubDemo
//
//  Created by Satyam Jaiswal on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class LanguagesTableViewCell: UITableViewCell {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var tickImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
