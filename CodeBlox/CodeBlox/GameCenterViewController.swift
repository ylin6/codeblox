//
//  GameCenterViewController.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/19/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit
import GameKit

class GameCenterViewController: UIViewController, EGCDelegate {
    var puzzle: Puzzle!;
    var randomNumber:UInt32!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        EGC.sharedInstance(self);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    func EGCAuthentified(authentified:Bool) {
        if(authentified){
            EGC.findMatchWithMinPlayers(2, maxPlayers: 2);
        } else{
            EGC.showGameCenterAuthentication();
        }
    }
    
    func sendRandomPuzzle(){
        let difficulties:[String] = ["Easy", "Medium", "Hard"];
        var difficulty:String = difficulties[Int(arc4random_uniform(3))];
        
        let fb = FirebaseServiceObject();
        fb.getPuzzleNames(["difficulty":difficulty]){ (results)->Void in
            var selectedPuzzleName:String = results[Int(arc4random_uniform(UInt32(results.count)))];
            fb.getPuzzle(["difficulty":difficulty, "puzzleName":selectedPuzzleName ]){(puzzle) -> Void in
                self.puzzle = puzzle;
                self.sendRandomNumber();
            }
        };
        
    }
    
    func sendRandomNumber(){
        randomNumber = arc4random();
        var info : [String: AnyObject] = ["packetName" : "puzzle" as! AnyObject,"randomNumber": randomNumber as! AnyObject, "Puzzle": puzzle];
        var data = NSKeyedArchiver.archivedDataWithRootObject(info)
        EGC.sendDataToAllPlayers(data, modeSend: .Reliable);
    }
    
    func ECGMatchStarted(){
        sendRandomPuzzle();
    }
    
    func ECGMatchRecept(match: GKMatch, didReceiveData data: NSData, fromPlayer playerID: String){
        let dictionary:[String: AnyObject] = (NSKeyedUnarchiver.unarchiveObjectWithData(data)! as? [String: AnyObject])!;
        if(dictionary["packetName"] as! String == "puzzle"){
            if(dictionary["randomNumber"] as! UInt32 > randomNumber){
                puzzle = dictionary["Puzzle"] as! Puzzle;
            } else if (dictionary["randomNumber"] as! UInt32 > randomNumber) {
                sendRandomNumber();
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?){
        if (segue.identifier == "showGameSegue"){
            let destinationController = segue.destinationViewController as! PuzzleViewController;
            var game = Game(puzzle: self.puzzle);
            game.multiplayer = true;
            destinationController.game = game;
        }
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
