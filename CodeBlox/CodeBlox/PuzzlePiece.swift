//
//  PuzzlePiece.swift
//  
//
//  Created by Yucheng Lin on 4/5/16.
//
//

import UIKit

class PuzzlePiece: NSObject {
    var correctIndex:Int;
    var codeLine:String;
    
    init(correctIndex:Int, codeLine:String){
        self.correctIndex = correctIndex;
        self.codeLine = codeLine;
    }
}
