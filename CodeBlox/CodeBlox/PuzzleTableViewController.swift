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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
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
