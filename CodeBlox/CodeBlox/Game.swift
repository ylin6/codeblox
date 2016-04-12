//
//  Game.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/11/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

class Game: NSObject {
    var score:Int = 0;
    var timeStarted = NSTimeInterval();
    var timeFinished:NSTimeInterval?;
    var puzzle:Puzzle;
    
    init(puzzle:Puzzle){
        self.puzzle = puzzle;
    }
}
