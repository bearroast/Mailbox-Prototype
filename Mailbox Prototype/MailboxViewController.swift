//
//  MailboxViewController.swift
//  Mailbox Prototype
//
//  Created by Bjørn Eivind Rostad on 9/27/14.
//  Copyright (c) 2014 Bjørn Eivind Rostad. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchView: UIImageView!
    @IBOutlet weak var helpView: UIImageView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    
    var messageCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1380)
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onPanMessage(gestureRecognizer: UIPanGestureRecognizer) {
        
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.translationInView(view)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            messageCenter = messageView.center
            
            println("panning began")
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            messageView.center.x = translation.x + messageCenter.x
            println("Translation: \(translation)")
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
//            if velocity.x < 150 {
//                self.messageView.center.x = 320
//            } else {
//                self.messageView.center.x = -160
//            }
        }
        
    }
    
}
