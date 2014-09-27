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
    @IBOutlet weak var messageIconView: UIView!
    
    var messageCenter: CGPoint!
    
    
    
    let yellow = UIColor(red: 1, green: 0.83, blue: 0.13, alpha: 1)
    let brown = UIColor(red: 0.85, green: 0.65, blue: 0.46, alpha: 1)
    let green = UIColor(red: 0.38, green: 0.85, blue: 0.38, alpha: 1)
    let red = UIColor(red: 0.94, green: 0.33, blue: 0.05, alpha: 1)
    let gray = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    
    
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
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            messageView.center.x = translation.x + messageCenter.x
            println("Translation: \(translation)")
            
            // Later
            if translation.x < -200 {
                messageIconView.backgroundColor = brown
                
            // List
            } else if translation.x < -50 {
                messageIconView.backgroundColor = yellow
                
            // List (not active)
            } else if translation.x < 0 {
                messageIconView.backgroundColor = gray
                
            // Archive (not active)
            } else if translation.x < 50 {
                messageIconView.backgroundColor = gray
                
            // Archive
            } else if translation.x < 200 {
                messageIconView.backgroundColor = green
                
            // Trash
            } else {
                messageIconView.backgroundColor = red
            }
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                // Later
                if translation.x < -200 {
                    self.messageView.center.x = 160
                    
                // List
                } else if translation.x < -50 {
                    self.messageView.center.x = 160
                
                // Reset
                } else if translation.x < -49 && translation.x < 50 {
                    self.messageView.center.x = 160
                
                // Archive
                } else if translation.x < 200 {
                    self.messageView.center.x = 160
                    
                // Trash
                } else {
                    self.messageView.center.x = 160
                
                }
                
            })

        }
        
    }
    
}
