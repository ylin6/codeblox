//
//  ScoreViewController.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/17/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    var game:Game?;
    
    var animationTimer: NSTimer!;
    var count = 0;
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreMeterView: MeterView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var attempLabel: UILabel!
    @IBOutlet weak var rewindButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        rewindButton.layer.cornerRadius = 75/2;
        
        timeLabel.text = timeToString();
        attempLabel.text = String(game!.attempts);
        animationTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "animateMeter", userInfo: nil, repeats: true);
    }
    
    func timeToString()->String{
        var minute:String;
        var second:String;
        
        minute = String(Int((game?.timeElapsed)! / 60));
        second = String(Int((game?.timeElapsed)! % 60 ));
        return "\(minute):\(second)";
    }
    
    override func viewDidAppear(animated: Bool) {
        scoreMeterView.score = (game?.score)!;
        scoreMeterView.updateAnimation();
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
