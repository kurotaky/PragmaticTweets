//
//  ParsedTweetCell.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/11/07.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import UIKit

class ParsedTweetCell: UITableViewCell {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var tweetTextLabel: UILabel!
    @IBOutlet var createdAtLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
