//
//  TwitterAPIRequestDelegate.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/11/21.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import Foundation

protocol TwitterAPIRequestDelegate {
    func handleTwitterData (data: NSData!,
        urlResponse: NSHTTPURLResponse!,
        error: NSError!,
        fromRequest: TwitterAPIRequest!)
}