//
//  ParsedTweet.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/11/06.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import UIKit

class ParsedTweet: NSObject {
    var tweetText : String?
    var userName : String?
    var createdAt : String?
    var userAvatarURL : NSURL?

    init(tweetText: String?, userName: String?, createdAt: String?, userAvatarURL: NSURL?) {
        super.init()
        self.tweetText = tweetText
        self.userName = userName
        self.createdAt = createdAt
        self.userAvatarURL = userAvatarURL
    }
    override init() {
        super.init()
        self.tweetText = ""
        self.userName = ""
        self.createdAt = ""
        self.userAvatarURL = nil
    }
}
