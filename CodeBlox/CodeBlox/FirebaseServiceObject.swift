//
//  FirebaseServiceObject.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/5/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit
import Firebase

class FirebaseServiceObject: NSObject {
    var rootRefURL:String = "https://codeblox.firebaseio.com/Puzzles/";
    
    func getPuzzle(input:[String:String], callback:(Puzzle)->Void){
        var rootRef:Firebase;
        var pieces:[PuzzlePiece] = [];
 
        if(input["puzzleName"] != nil ){
            rootRef = Firebase(url: "\(rootRefURL)\(input["difficulty"]!)/\(input["puzzleName"]!)");
            print(rootRef);
            
            rootRef.observeSingleEventOfType(.Value, withBlock:{ snapshot in
                for line in snapshot.children.allObjects as! [FDataSnapshot]{
                    pieces.append(PuzzlePiece(correctIndex: Int(line.key)!, codeLine: line.value as! String));
                    print("\(line.key): \(line.value)");
                }
                
                let puzzle = Puzzle(pieces: pieces);
                callback(puzzle);
            });
        }
    }
    
    func getPuzzleNames(input:[String:String], callback:([String])->Void){
        var rootRef:Firebase;
        var puzzleNames:[String] = [];
        rootRef = Firebase(url: "\(rootRefURL)\(input["difficulty"]!)");
        print(rootRef);
        
        rootRef.observeSingleEventOfType(.Value, withBlock:{ snapshot in
            for puzzle in snapshot.children.allObjects as! [FDataSnapshot]{
                puzzleNames.append(puzzle.key);
                print(puzzleNames);
                callback(puzzleNames);
            }
        });
        
    }
    
    
}
