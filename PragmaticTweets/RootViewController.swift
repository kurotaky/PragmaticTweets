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

public class RootViewController: UITableViewController, TwitterAPIRequestDelegate {
    
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
        
        println("RootViewController \(__FUNCTION__)")
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
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                {() -> Void in
                    let avatarImage = UIImage(data: NSData (
                        contentsOfURL: parsedTweet.userAvatarURL!)!)
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            if cell.userNameLabel.text == parsedTweet.userName {
                                cell.avatarImageView.image = avatarImage
                            } else {
                                println("oops, wrong cell, never mind")
                            }
                    })
                }
            )
            cell.avatarImageView.image = UIImage (data: NSData(contentsOfURL: parsedTweet.userAvatarURL!)!)
        }
        return cell
    }
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let parsedTweet = parsedTweets[indexPath.row]
        if self.splitViewController != nil {
            if (self.splitViewController!.viewControllers.count > 1) {
                if let tweetDetailNav = self.splitViewController!.viewControllers[1] as? UINavigationController {
                    if let tweetDetailVC = tweetDetailNav.viewControllers[0] as? TweetDetailViewController {
                        tweetDetailVC.tweetIdString = parsedTweet.tweetIdString
                    }
                }
            }
        }
    }
    
    func reloadTweets() {
        let twitterParams : Dictionary = ["count":"100"]
        let twitterAPIURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        let request = TwitterAPIRequest()
        request.sendTwitterRequest(twitterAPIURL, params: twitterParams, delegate: self)
    }

    func handleTwitterData(data: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!, fromRequest: TwitterAPIRequest!) {
        if let dataValue = data {
            var parseError : NSError? = nil
            let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(dataValue, options: NSJSONReadingOptions(0), error: &parseError)
            if parseError != nil {
                return
            }
            if let jsonArray = jsonObject as? Array<Dictionary<String, AnyObject>> {
                self.parsedTweets.removeAll(keepCapacity: true)
                for tweetDict in jsonArray {
                    let parsedTweet = ParsedTweet()
                    parsedTweet.tweetText = tweetDict["text"] as? NSString
                    parsedTweet.createdAt = tweetDict["created_at"] as? NSString
                    let userDict = tweetDict["user"] as NSDictionary
                    parsedTweet.userName = userDict["name"] as? NSString
                    parsedTweet.userAvatarURL = NSURL(string: userDict["profile_image_url"] as NSString!)
                    parsedTweet.tweetIdString = tweetDict["id_str"] as? NSString
                    self.parsedTweets.append(parsedTweet)
                }
                dispatch_async(dispatch_get_main_queue(), { ()-> Void in self.tableView.reloadData() })
            }
            // println("JSON error: \(parseError)\nJSON response: \(jsonObject)")
            println("ほおおおおおおおおおおおおおおおおおおおお")
        } else {
            println("handleTweetData recieved no data")
        }
    }
    @IBAction func handleTweetButtonTapped(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let tweetVC = SLComposeViewController (forServiceType: SLServiceTypeTwitter)
            let message = NSBundle.mainBundle().localizedStringForKey(
                "I just finished the first project in iOS SDK Development. #pragsios",
                value: "",
                table: nil)
            tweetVC.setInitialText(message)
            tweetVC.completionHandler = {
                (SLComposeViewControllerResult result) -> Void in
                if result == SLComposeViewControllerResult.Done {
                    self.reloadTweets()
                }
            }
            self.presentViewController(tweetVC, animated: true, completion: nil)
        } else {
            println ("Can't send tweet")
        }
    }
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("segue.identifier = \(segue.identifier)")
        if segue.identifier == "showTweetDetailsSegue" {
            if let tweetDetailVC = segue.destinationViewController as? TweetDetailViewController {
                let row = self.tableView!.indexPathForSelectedRow()!.row
                let parsedTweet = parsedTweets [row] as ParsedTweet
                tweetDetailVC.tweetIdString = parsedTweet.tweetIdString
            }
        }
    }
}