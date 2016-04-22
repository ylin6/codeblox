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
        
        //easyButton.center.y = super.view.center.y/2;
        //hardButton.center.y = super.view.center.y * 3/4;
        // Do any additional setup after loading the view.
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
        
    }
    
    @IBAction func hardPuzzles(sender: AnyObject) {
        self.difficulty = "Hard";
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if(segue.identifier == "showPuzzlesSegue"){
            let destinationController = segue.destinationViewController as! PuzzleTableViewController;
            destinationController.difficulty = self.difficulty;
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
