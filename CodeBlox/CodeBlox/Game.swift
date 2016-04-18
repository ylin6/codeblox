//
//  Game.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/11/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

let timeThreshold:Double = 500.0;

class Game: NSObject {
    var score:Int = 0;
    var timeStarted: NSDate;
    var timeElapsed: NSTimeInterval?;
    var puzzle:Puzzle;
    
    init(puzzle:Puzzle){
        self.puzzle = puzzle;
        self.timeStarted = NSDate();
    }
    
    func getScore(){
        self.timeElapsed = NSDate().timeIntervalSinceDate(self.timeStarted);
        if (timeElapsed > timeThreshold){
            self.score = 10;
        } else{
            self.score = Int((timeThreshold - timeElapsed!) * 100 / timeThreshold);
        }
    }
}
