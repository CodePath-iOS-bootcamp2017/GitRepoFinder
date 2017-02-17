//
//  RepoTableViewCell.swift
//  GithubDemo
//
//  Created by Satyam Jaiswal on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    var repo:GithubRepo?{
        didSet{
            if let urlString = repo?.ownerAvatarURL{
                if let avatarUrl = URL(string: urlString){
                    self.avatarImageView.setImageWith(avatarUrl)
                }
            }
            
            self.nameLabel.text = repo?.name
            self.ownerLabel.text =  repo?.ownerHandle
            self.descriptionLabel.text = repo?.repoDescription
            
            if let forkCount = repo?.forks{
                self.forksLabel.text = "\(forkCount)"
            }
            
            if let starCount = repo?.stars{
                self.forksLabel.text = "\(starCount)"
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
