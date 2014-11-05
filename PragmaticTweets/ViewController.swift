//
//  ViewController.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/10/02.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import UIKit
import Social

public class ViewController: UITableViewController {

    @IBOutlet public weak var twitterWebView: UIWebView!

    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.textLabel.text = "Row \(indexPath.row)"
        return cell
    }
}

