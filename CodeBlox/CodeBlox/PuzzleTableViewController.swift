//
//  PuzzleTableViewController.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/6/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

class PuzzleTableViewController: UITableViewController {
    var difficulty:String?
    var puzzleNames:[String] = [];
    @IBOutlet var puzzleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fb = FirebaseServiceObject();
        fb.getPuzzleNames(["difficulty":difficulty!]){ (results)->Void in
            self.puzzleNames = results;
            self.puzzleTable.reloadData();
        };

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (puzzleNames.count);
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = puzzleTable.dequeueReusableCellWithIdentifier("puzzleCell", forIndexPath: indexPath) as UITableViewCell!
        cell.textLabel?.text = puzzleNames[indexPath.row];
        // Configure the cell...
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showPuzzleSegue"){
            let indexPath: NSIndexPath = self.puzzleTable.indexPathForSelectedRow!
            let destinationController = segue.destinationViewController as! PuzzleViewController;
            destinationController.input = ["difficulty":self.difficulty!, "puzzleName":puzzleNames[indexPath.row]];
            
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showPuzzleSegue", sender: self);
    }


}
