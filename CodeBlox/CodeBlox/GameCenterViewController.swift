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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var leaderBoardButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad();
        loginButton.layer.cornerRadius = 75/2;
        leaderBoardButton.layer.cornerRadius = 75/2;
        EGC.sharedInstance(self);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        EGC.delegate = self;
    }
    
    func sendRandomPuzzle(){
        let difficulties:[String] = ["Easy", "Medium", "Hard"];
        let difficulty:String = difficulties[Int(arc4random_uniform(3))];
        
        let fb = FirebaseServiceObject();
        fb.getPuzzleNames(["difficulty":difficulty]){ (results)->Void in
            let selectedPuzzleName:String = results[Int(arc4random_uniform(UInt32(results.count)))];
            fb.getPuzzle(["difficulty":difficulty, "puzzleName":selectedPuzzleName ]){(puzzle) -> Void in
                self.puzzle = puzzle;
                self.sendRandomNumber();
            }
        };
        
    }
    
    func sendRandomNumber(){
        randomNumber = arc4random();
        let info : [String: AnyObject] = ["packetName" : "puzzle" as AnyObject,"randomNumber": randomNumber as! AnyObject, "Puzzle": puzzle];
        let data = NSKeyedArchiver.archivedDataWithRootObject(info)
        EGC.sendDataToAllPlayers(data, modeSend: .Reliable);
    }
    
    func ECGMatchStarted(){
        print("matchStarted");
        //sendRandomPuzzle();
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
        
        print("MATCHRECEPT");
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?){
        if (segue.identifier == "showGameSegue"){
            let destinationController = segue.destinationViewController as! PuzzleViewController;
            let game = Game(puzzle: self.puzzle);
            game.multiplayer = true;
            destinationController.game = game;
        }
    }
    
    
    @IBAction func login(sender: AnyObject) {
        EGC.findMatchWithMinPlayers(2, maxPlayers: 2);
    }
    

    @IBAction func showLeaderBoard(sender: AnyObject) {
        EGC.showGameCenterLeaderboard(leaderboardIdentifier: "codebloxleaderboard");
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
