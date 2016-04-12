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
    
    init(pieces:[PuzzlePiece]){
        self.pieces = pieces;
    }
    
    func scramble(){
        pieces = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(pieces) as! [PuzzlePiece];
    }
    
    func checkSolved()->Bool{
        for(var i = 0; i < pieces.count; i++){
            print("i: \(i) : \(pieces[i].correctIndex)");
            if(i != pieces[i].correctIndex){
                return false;
            }
        }
        
        return true;
    }
    
}
