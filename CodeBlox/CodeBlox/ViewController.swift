//
//  ViewController.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/5/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var singlePlayerButton: UIButton!
    @IBOutlet weak var multiplayerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        singlePlayerButton.layer.cornerRadius = singlePlayerButton.bounds.height/2;
        multiplayerButton.layer.cornerRadius = multiplayerButton.bounds.height/2;
        
        let spy = singlePlayerButton.center.y;
        let mpy = singlePlayerButton.center.y;
        
        
        singlePlayerButton.center.y = self.view.bounds.height + 500;
        multiplayerButton.center.y = self.view.bounds.height + 1000;
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations:{
            self.singlePlayerButton.center.y = spy;
            self.multiplayerButton.center.y = mpy;
            }, completion: nil);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func singlePlayer(sender: AnyObject) {
        performSegueWithIdentifier("showDifficultySegue", sender: self);
    }

}

