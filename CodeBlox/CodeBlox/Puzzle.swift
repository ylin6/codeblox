//
//  Puzzles.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/5/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit
import GameKit

class Puzzle: NSObject {
    var pieces = [PuzzlePiece]();
    var locked:Bool = false;
    var prompt:String?
    
    init(pieces:[PuzzlePiece], prompt:String){
        self.pieces = pieces;
        self.prompt = prompt;
    }
    
    func scramble(){
        pieces = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(pieces) as! [PuzzlePiece];
    }
    
    func checkSolved()->[Int]{
        var wrongArray = [Int]();
        for(var i = 0; i < pieces.count; i++){
            //print("i: \(i) : \(pieces[i].correctIndex)");
            if(i != pieces[i].correctIndex){
                wrongArray.append(i);
            }
        }
        
        return wrongArray;
    }
    
}
