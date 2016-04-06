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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func singlePlayer(sender: AnyObject) {
        performSegueWithIdentifier("showDifficultySegue", sender: self);
    }

}

