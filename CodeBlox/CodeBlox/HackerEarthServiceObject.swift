//
//  HackerEarthServiceObject.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/20/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit
import Alamofire

class HackerEarthServiceObject: NSObject {
    
    var endpoint:NSURL = NSURL(string:"https://api.hackerearth.com/v3/code/run/")!;
    var clientID:String = "a645f1040a50e115368a7b8292e3d2764251f045d8f5.api.hackerearth.com";
    var secretKey:String = "86c7622885426ad4bb9d72f94e7c7e7e4206c5b6";
    
    func run(source:String, callback:(String) -> Void){
        
        var output:String = "";
        
        /*
        let requestData:String  = "client_secret=\(secretKey)&source=\(source)&async=0&lang=JAVASCRIPT&time_limit=5&memory_limit=262144";
        let request = NSMutableURLRequest(URL: endpoint);
        request.HTTPMethod = "POST";
        request.HTTPBody = requestData.dataUsingEncoding(NSUTF8StringEncoding);
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept");
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            let json = JSON(data: data!);
            print(json);
            
            if(json["run_status"]["output"] == nil){
                output = json["run_status"]["status_detail"].string!;
            } else{
                output  = json["run_status"]["output"].string!;
            }
        }
            
        task.resume();*/
        
        var param = ["source": source, "client_secret": secretKey, "async": 0, "lang": "JAVASCRIPT"]
        Alamofire.request(.POST, endpoint, parameters: param as! [String : AnyObject])
            .responseJSON { response in
                
                if let data = response.result.value as? [String: AnyObject] {
                    let o = data["run_status"] as? [String: AnyObject];
                    
                    if(o!["output"] == nil){
                        output = "Error"
                    } else{
                        output = o!["output"] as! String;
                    }
                }
                print(output);
                callback(output);
        }
    }
    
}
