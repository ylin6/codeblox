//
//  ScoreViewController.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/17/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, EGCDelegate {
    var game:Game?;
    
    var animationTimer: NSTimer!;
    var count = 0;
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreMeterView: MeterView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var attempLabel: UILabel!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        rewindButton.layer.cornerRadius = 75/2;
        leaderboardButton.layer.cornerRadius = 75/2;
        EGC.sharedInstance(self);
        timeLabel.text = timeToString();
        attempLabel.text = String(game!.attempts);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        EGC.delegate = self;
        scoreMeterView.score = (game?.score)!;
        scoreMeterView.updateAnimation();
        animationTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "animateMeter", userInfo: nil, repeats: true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateMeter(){
        if(count <= game!.score){
            scoreLabel.text = String(count);
            count+=1;
        } else{
            animationTimer.invalidate();
        }
    }
    
    func EGCAuthentified(authentified:Bool) {
        EGC.reportScoreLeaderboard(leaderboardIdentifier: "codebloxleaderboard", score: game!.score);
    }
    
    
    
    func timeToString()->String{
        var minute:Int;
        var second:Int;
        
        minute = Int((game?.timeElapsed)! / 60);
        second = Int((game?.timeElapsed)! % 60);
        
        var minuteString:String = "\(minute)";
        var secondString:String = "\(second)";
        
        if(minute<10){
            minuteString = "0\(minute)";
        }
        
        if(second<10){
            secondString = "0\(second)";
        }
        
        return "\(minuteString):\(secondString)";
    }
    
    
    @IBAction func showLeaderboard(sender: AnyObject) {
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
