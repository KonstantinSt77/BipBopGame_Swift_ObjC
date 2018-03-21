//
//  MGStartVC.swift
//  Math Game Swift
//
//  Created by Konstantin on 21.03.2018.
//  Copyright © 2018 Stolyarenko Konstantin. All rights reserved.
//

import UIKit

class MGStartVC: UIViewController
{
      @IBOutlet weak var textView: UITextView!
 
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.textView.isHidden = true
        self.textView.alpha = 0.0
        self.textView.clipsToBounds = true
        self.textView.layer.cornerRadius = 20
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(MGStartVC.swipeGesture))
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
    }

    @IBAction func openRules(_ sender: Any)
    {
        if(self.textView.isHidden)
        {
            self.textView.isHidden = false
            
            UIView.transition(with: self.textView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.textView.alpha = 1.0
            }, completion: nil)
            
        }
        else
        {
            UIView.transition(with: self.textView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.textView.alpha = 0.0
            }, completion: { (finished: Bool) -> () in
             self.textView.isHidden = true})
        }
    }
    
    @objc func swipeGesture()
    {
        performSegue(withIdentifier:"StartPlayingSegue", sender: nil)
    }
 
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
