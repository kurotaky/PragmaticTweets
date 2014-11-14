//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/10/02.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import Accounts
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
    
    @IBAction func handleRefresh(sender: AnyObject?) {
        self.parsedTweets.append(ParsedTweet (tweetText: "New row", userName: "@refresh", createdAt: NSDate().description, userAvatarURL: defaultAvatarURL))
        reloadTweets()
        refreshControl!.endRefreshing()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        reloadTweets()
        var refresher = UIRefreshControl()
        refresher.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresher
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
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTweetCell") as ParsedTweetCell
        let parsedTweet = parsedTweets[indexPath.row]
        cell.userNameLabel.text = parsedTweet.userName
        cell.tweetTextLabel.text = parsedTweet.tweetText
        cell.createdAtLabel.text = parsedTweet.createdAt
        if parsedTweet.userAvatarURL != nil {
            cell.avatarImageView.image = UIImage (data: NSData(contentsOfURL: parsedTweet.userAvatarURL!)!)
        }
        return cell
    }
    
    func reloadTweets() {
        let accountStore = ACAccountStore()
        let twitterAccountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(twitterAccountType, options: nil, completion: {
            (Bool granted, NSError error) -> Void in
            if (!granted) {
                println("account access not granted")
            } else {
                println("account access granted")
                let twitterAccounts = accountStore.accountsWithAccountType(twitterAccountType)
                if twitterAccounts.count == 0 {
                    println("no twitter accounts configured")
                    return
                } else {
                    let twitterParams = [
                        "count" : "100"
                    ]
                    let twitterAPIURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
                    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: twitterAPIURL, parameters: twitterParams)
                    request.account = twitterAccounts[0] as ACAccount
                    request.performRequestWithHandler({
                        (NSData data, NSHTTPURLResponse urlResponse, NSError error) -> Void in
                        self.handleTweeterData(data, urlResponse: urlResponse, error: error)
                    })
                }
            }
        })
    }

    func handleTweeterData(data: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) {
        if let dataValue = data {
            var parseError : NSError? = nil
            let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions(0), error: &parseError)
            println("JSON error: \(parseError)\nJSON response: \(jsonObject)")
        } else {
            println("handleTweetData recieved no data")
        }
    }
}