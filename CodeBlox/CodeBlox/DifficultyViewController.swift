//
//  DifficultyViewController.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/5/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    var difficulty:String?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        easyButton.layer.cornerRadius = easyButton.bounds.height/2;
        mediumButton.layer.cornerRadius = mediumButton.bounds.height/2;
        hardButton.layer.cornerRadius = hardButton.bounds.height/2;
        
        let eby = easyButton.center.y;
        let mby = mediumButton.center.y;
        let hby = hardButton.center.y
        
        
        easyButton.center.y = self.view.bounds.height + 500;
        mediumButton.center.y = self.view.bounds.height + 1000;
        hardButton.center.y = self.view.bounds.height + 500;
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations:{
            self.easyButton.center.y = eby;
            self.mediumButton.center.y = mby;
            self.hardButton.center.y = hby;
            }, completion: nil);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func easyPuzzles(sender: AnyObject) {
        self.difficulty = "Easy";
        performSegueWithIdentifier("showPuzzlesSegue", sender: self);
    }
    
    @IBAction func mediumPuzzles(sender: AnyObject) {
        self.difficulty = "Medium";
        performSegueWithIdentifier("showPuzzlesSegue", sender: self);
        
    }
    
    @IBAction func hardPuzzles(sender: AnyObject) {
        self.difficulty = "Hard";
        performSegueWithIdentifier("showPuzzlesSegue", sender: self);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if(segue.identifier == "showPuzzlesSegue"){
            let destinationController = segue.destinationViewController as! PuzzleTableViewController;
            destinationController.difficulty = self.difficulty;
        }
    }


}
