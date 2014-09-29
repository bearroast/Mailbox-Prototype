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
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    @IBOutlet weak var laterView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    var messageCenter: CGPoint!
    
    
    let yellow = UIColor(red: 1, green: 0.83, blue: 0.13, alpha: 1)
    let brown = UIColor(red: 0.85, green: 0.65, blue: 0.46, alpha: 1)
    let green = UIColor(red: 0.38, green: 0.85, blue: 0.38, alpha: 1)
    let red = UIColor(red: 0.94, green: 0.33, blue: 0.05, alpha: 1)
    let gray = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: searchView.image!.size.height + helpView.image!.size.height + messageView.image!.size.height + feedView.image!.size.height)
        scrollView.delegate = self
        
        laterView.alpha = 0
        listView.alpha = 0
        
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
            
            archiveIcon.alpha = 0
            deleteIcon.alpha = 0
            listIcon.alpha = 0
            laterIcon.alpha = 0
            
            println(translation.x)
            
            // List (brown)
            if translation.x < -260 {
                messageIconView.backgroundColor = brown
                laterIcon.alpha = 1
                laterIcon.center.x = translation.x + 350
                
            // Later (yellow)
            } else if translation.x < -60 {
                messageIconView.backgroundColor = yellow
                listIcon.alpha = 1
                listIcon.center.x = translation.x + 350
                
            // Later (not active)
            } else if (translation.x < 0 && translation.x > -60) {
                messageIconView.backgroundColor = gray
                listIcon.alpha = 1
                listIcon.center.x = 290
                
            // Archive (not active)
            } else if (translation.x > 0 &&  translation.x < 60) {
                messageIconView.backgroundColor = gray
                archiveIcon.alpha = 1
                archiveIcon.center.x = 30
                
                
            // Archive (green)
            } else if (translation.x) < 260 {
                messageIconView.backgroundColor = green
                archiveIcon.alpha = 1
                archiveIcon.center.x = translation.x - 30
                
            // Trash (red)
            } else {
                messageIconView.backgroundColor = red
                deleteIcon.alpha = 1
                deleteIcon.center.x = translation.x - 30
            }
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
                
            // List (brown)
            if translation.x < -260 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.center.x = -320-180-30-(25/2)
                    self.laterIcon.center.x = -320-30
                    }, completion: nil)
                
            // Later (yellow)
            } else if translation.x < -60 && translation.x > -260 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.center.x = -320-180-30-(25/2)
                    self.listIcon.center.x = -320-30
                    }, completion: nil)
                
            // Reset
            } else if translation.x > -60 && translation.x < 60 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.center.x = 160
                    }, completion: nil)
                
            // Archive
            } else if translation.x > 60 && translation.x < 260 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.center.x = 320+180+30+(25/2) // with message + move 180 (off the side) + 30 padding from Changed + center of icon
                    self.archiveIcon.center.x = 320+30 // width of screen + 30 padding
                }, completion: nil)
                
                
            // Trash
            } else if translation.x > 260 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.center.x = 320+180+30+(25/2)
                    self.deleteIcon.center.x = 320+30
                    }, completion: nil)
            }
            
            
        }
        
    }
    
}