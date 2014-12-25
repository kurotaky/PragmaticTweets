//
//  UserImageDetailViewController.swift
//  PragmaticTweets
//
//  Created by usr0600244 on 2014/12/18.
//  Copyright (c) 2014年 mo-fu. All rights reserved.
//

import UIKit

class UserImageDetailViewController: UIViewController {
    var userImageURL : NSURL?
    var preGestureTransform : CGAffineTransform?

    @IBOutlet weak var userImageView: UIImageView!
    @IBAction func handlePanGesture(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            self.preGestureTransform = self.userImageView.transform
        }
        if sender.state == UIGestureRecognizerState.Began || sender.state == UIGestureRecognizerState.Changed {
            let translation = sender.translationInView(self.userImageView)
            println(translation)
            let translatedTransform = CGAffineTransformTranslate(self.preGestureTransform!, translation.x, translation.y)
            self.userImageView.transform = translatedTransform
        }
    }

    @IBAction func handleDoubleTapGesture(sender: UITapGestureRecognizer) {
        println("before \(self.userImageView.frame)")
        self.userImageView.transform = CGAffineTransformIdentity
        println("after \(self.userImageView.frame)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.userImageURL != nil {
            if let imageData = NSData(contentsOfURL: self.userImageURL!) {
                self.userImageView.image = UIImage(data: imageData)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
