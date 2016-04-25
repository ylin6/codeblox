//
//  GameCenterViewController.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/19/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

class GameCenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        GCHelper.sharedInstance.authenticateLocalUser();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
