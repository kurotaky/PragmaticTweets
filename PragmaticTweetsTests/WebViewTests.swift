//
//  WebViewTests.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/10/30.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import UIKit
import XCTest
import PragmaticTweets

class WebViewTests: XCTestCase, UIWebViewDelegate {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAutomaticWebLoad() {
        if let viewController = UIApplication.sharedApplication().windows[0].rootViewController as? ViewController {
            viewController.twitterWebView.delegate = self
            self.loadWebViewExpectation = expectationWithDescription("web view auto-load test")
            waitForExpectationsWithTimeout(5.0, handler: nil)
            /* let webViewContents = viewController.twitterWebView.stringByEvaluatingJavaScriptFromString("document.documentElement.textContent")
            XCTAssertNotNil(webViewContents, "web view contents are nil")
            XCTAssertNotEqual(webViewContents!, "", "web viewcontents are empty")
            */
        } else {
            XCTFail("couldn't get root view controller")
        }
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        XCTFail("web view load failed")
        self.loadWebViewExpectation!.fulfill()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if let webViewContents = webView.stringByEvaluatingJavaScriptFromString("document.documentElement.textContent") {
            if webViewContents != "" {
                self.loadWebViewExpectation!.fulfill()
            }
        }
    }

    var loadWebViewExpectation : XCTestExpectation?

}
