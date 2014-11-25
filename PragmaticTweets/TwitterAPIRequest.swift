//
//  TwitterAPIRequest.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/11/21.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import UIKit
import Social
import Accounts

class TwitterAPIRequest: NSObject {
    func sendTwitterRequest(requestURL:NSURL!,
        params: Dictionary<String, String>,
        delegate: TwitterAPIRequestDelegate?) {
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
                        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: params)
                        request.account = twitterAccounts[0] as ACAccount
                        request.performRequestWithHandler({
                            (NSData data, NSHTTPURLResponse urlResponse, NSError error) -> Void in
                            delegate!.handleTwitterData(data, urlResponse: urlResponse, error: error, fromRequest: self)
                        })
                    }
                }
            })
    }
   
}
