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
    

    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var menuView: UIImageView!
    
    @IBOutlet weak var contentView: UIView!
    
    var messageCenter: CGPoint!
    var contentCenter: CGPoint!
    
    
    let yellow = UIColor(red: 1, green: 0.83, blue: 0.13, alpha: 1)
    let brown = UIColor(red: 0.85, green: 0.65, blue: 0.46, alpha: 1)
    let green = UIColor(red: 0.38, green: 0.85, blue: 0.38, alpha: 1)
    let red = UIColor(red: 0.94, green: 0.33, blue: 0.05, alpha: 1)
    let gray = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
   
    // Converts values (copypasta from Dropbox)
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: searchView.image!.size.height + helpView.image!.size.height + messageView.image!.size.height + feedView.image!.size.height)
        scrollView.delegate = self
        
        laterView.alpha = 0
        listView.alpha = 0
        
        println("Manu alpha is \(menuView.alpha)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTapHamburger(sender: UIButton) {
        println("Manu alpha is \(menuView.alpha)")
        menuView.alpha = 1
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.scrollView.transform = CGAffineTransformMakeTranslation(280, 0)
            self.navigationBar.transform = CGAffineTransformMakeTranslation(280, 0)
        })
    }
    
    
    
    @IBAction func onTapListView(sender: UITapGestureRecognizer) {
        println("tap")
        UIView.animateWithDuration(0.2, delay: 0.2, options: nil, animations: { () -> Void in
            self.listView.alpha = 0
            }, completion: nil)
        self.updateScrollView()
        
    }
    @IBAction func onTapLaterView(sender: UITapGestureRecognizer) {
        println("tap")
        UIView.animateWithDuration(0.2, delay: 0.2, options: nil, animations: { () -> Void in
            self.laterView.alpha = 0
        }, completion: nil)
        self.updateScrollView()

    }

    func updateScrollView() {
        UIView.animateWithDuration(0.2, delay: 0.5, options: nil, animations: { () -> Void in
            self.scrollView.contentSize = CGSize(width: 320, height: self.searchView.image!.size.height + self.helpView.image!.size.height + self.feedView.image!.size.height)
            self.feedView.center.y -= self.messageView.image!.size.height
        }, completion: nil)
    }
    
    func swipeLeft() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.messageView.center.x = -320-180-30-(25/2)
                self.listIcon.center.x = -320-30
                self.laterIcon.center.x = -320-30
            }, completion: nil)
    }
    
    func swipeRight() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.messageView.center.x = 320+180+30+(25/2)
            self.archiveIcon.center.x = 320+30
            self.deleteIcon.center.x = 320+30
            }, completion: nil)
    }
    
    @IBAction func onEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        menuView.alpha = 1
        
        var location = gestureRecognizer.locationInView(contentView)
        var translation = gestureRecognizer.translationInView(contentView)
        var velocity = gestureRecognizer.translationInView(contentView)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            contentCenter = contentView.center
            println("panning from edge")     // ugh not working

        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("panning changed")
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
        }
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
                var listIconAlpha = convertValue(Float(translation.x), r1Min: 0, r1Max: -60, r2Min: 0, r2Max: 1)
                listIcon.alpha = CGFloat(listIconAlpha)
                listIcon.center.x = 290
                
            // Archive (not active)
            } else if (translation.x > 0 &&  translation.x < 60) {
                messageIconView.backgroundColor = gray
                var archiveIconAlpha = convertValue(Float(translation.x), r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1)
                archiveIcon.alpha = CGFloat(archiveIconAlpha)
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
                self.swipeLeft()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.listView.alpha = 1
                    }, completion: nil)
                
            // Later (yellow)
            } else if translation.x < -60 && translation.x > -260 {
                self.swipeLeft()
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.laterView.alpha = 1
                    }, completion: nil)
                
            // Reset
            } else if translation.x > -60 && translation.x < 60 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageView.center.x = 160
                    }, completion: nil)
                
            // Archive
            } else if translation.x > 60 && translation.x < 260 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.swipeRight()
                    self.updateScrollView()
                    
                }, completion: nil)
                
                
            // Trash
            } else if translation.x > 260 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.swipeRight()
                    self.updateScrollView()
                    }, completion: nil)
            }
            
            
        }
        
    }
    
}