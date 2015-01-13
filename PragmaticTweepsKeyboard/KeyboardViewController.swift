//
//  KeyboardViewController.swift
//  PragmaticTweepsKeyboard
//
//  Created by usr0600244 on 2015/01/08.
//  Copyright (c) 2015年 mo-fu. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet weak var nextKeyboardBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    @IBAction func nextKeyboardBarButtonTapped(sender: UIBarButtonItem) {
        println("\(__FUNCTION__)")
        self.advanceToNextInputMode()
    }

    override func viewDidLoad() {
        println("\(__FUNCTION__)")
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        println("\(__FUNCTION__)")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
}