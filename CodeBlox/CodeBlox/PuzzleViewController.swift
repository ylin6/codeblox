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
    var game:Game = Game(puzzle: Puzzle(pieces: [], prompt: "", expectedOutput:""
        ));
    var wrongArray = [Int]();
    
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var puzzlePiecesTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let fb = FirebaseServiceObject();
        fb.getPuzzle(input!){ (puzzle)->Void in
            self.game = Game(puzzle:puzzle);
            self.game.puzzle.scramble();
            self.promptLabel.text = puzzle.prompt;
            self.puzzlePiecesTable.reloadData();
        }
        
        puzzlePiecesTable.editing = true;
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: "onSubmit");
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
        
        return (game.puzzle.pieces.count);
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = puzzlePiecesTable.dequeueReusableCellWithIdentifier("puzzlePieceCell", forIndexPath: indexPath) as UITableViewCell!
        
        if (wrongArray.contains(indexPath.row)){
            cell.backgroundColor = UIColor(red: 255.0/255.0, green: 62.0/155.0, blue: 62.0/255.0, alpha: 1.0)
        } else{
            cell.backgroundColor = UIColor(red:102.0/255.0, green:102.0/255.0, blue: 102.0/255.0, alpha: 1.0);
        }
        
        cell.textLabel?.text = game.puzzle.pieces[indexPath.row].codeLine;
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false;
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None;
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let movedPiece = game.puzzle.pieces[fromIndexPath.row]
        game.puzzle.pieces.removeAtIndex(fromIndexPath.row)
        game.puzzle.pieces.insert(movedPiece, atIndex: toIndexPath.row)
    }
    
    func onSubmit(){
        
        
        wrongArray = game.puzzle.checkSolved();
        //print("here + \(game.puzzle.runCode())");
        if(wrongArray.count == 0 || game.puzzle.runCode() ){
            puzzlePiecesTable.reloadData();
            game.getScore();
            performSegueWithIdentifier("showScoreSegue", sender: self);
        } else{
            print("false");
            puzzlePiecesTable.reloadData();
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showScoreSegue"){
            let destinationController = segue.destinationViewController as! ScoreViewController;
            destinationController.game = self.game;
            
        }
    }


}
