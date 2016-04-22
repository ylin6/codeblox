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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        animationTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "animateMeter", userInfo: nil, repeats: true);
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
