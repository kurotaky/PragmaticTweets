//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/10/02.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import UIKit
import Social

let defaultAvatarURL = NSURL(string: "https://abs.twimg.com/sticky/default_profile_images/" + "default_profile_6_200x200.png")

public class ViewController: UITableViewController {
    
    var parsedTweets : Array <ParsedTweet> = [
        ParsedTweet(tweetText:"iOS SDK Development now in print. " + "Swift programming FTW!",
        userName:"@pragprog",
        createdAt:"2014-08-20 16:44:30 EDT",
        userAvatarURL: defaultAvatarURL),
        ParsedTweet(tweetText:"Math is cool",
        userName:"@redqueencoder",
        createdAt:"2014-08-16 16:44:30 EDT",
        userAvatarURL: defaultAvatarURL),
        ParsedTweet(tweetText:"Anime is cool",
        userName:"@invalidname",
        createdAt:"2014-07-31 16:44:30 EDT",
        userAvatarURL: defaultAvatarURL)
    ]

    @IBOutlet public weak var twitterWebView: UIWebView!

    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reloadTweets()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsedTweets.count
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserAndTweetCell") as UITableViewCell
        let parsedTweet = parsedTweets[indexPath.row]
        cell.textLabel.text = parsedTweet.userName
        cell.detailTextLabel!.text = parsedTweet.tweetText
        return cell
    }
    
    func reloadTweets() {
        self.tableView.reloadData()
    }
    
}

