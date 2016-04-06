//
//  PuzzleViewController.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/6/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var input:[String:String]?;
    var puzzle:Puzzle = Puzzle(pieces: [PuzzlePiece(correctIndex: 0, codeLine: "")]);
    
    @IBOutlet weak var puzzlePiecesTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let fb = FirebaseServiceObject();
        fb.getPuzzle(input!){ (puzzle)->Void in
            self.puzzle = puzzle;
            print(puzzle);
            self.puzzlePiecesTable.reloadData();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return (puzzle.pieces.count)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = puzzlePiecesTable.dequeueReusableCellWithIdentifier("puzzlePieceCell", forIndexPath: indexPath) as UITableViewCell!
        cell.textLabel?.text = puzzle.pieces[indexPath.row].codeLine;
        return cell
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
