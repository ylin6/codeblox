//
//  MeterView.swift
//  CodeBlox
//
//  Created by Yucheng Lin on 4/18/16.
//  Copyright © 2016 Yucheng Lin & Marshall Sprigg. All rights reserved.
//

import UIKit

let PI:CGFloat = CGFloat(M_PI);

class MeterView: UIView {
    @IBInspectable var score: Int = 0;
    @IBInspectable var animating: Bool = true {
        didSet {
            updateAnimation()
        }
    }
    
    let MeterAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd");
        animation.fromValue = 0;
        animation.toValue = 1;
        animation.duration = 2;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        animation.repeatCount = 1;
        return animation;
    }()

    let bgLayer = CAShapeLayer();
    let meterLayer = CAShapeLayer();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        bgLayer.lineWidth = 36;
        meterLayer.lineWidth = 30;
        bgLayer.fillColor = nil;
        meterLayer.fillColor = nil;
        bgLayer.strokeColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0).CGColor;
        meterLayer.strokeColor = UIColor(red: 51/255.0, green: 255/255.0, blue: 153/255.0, alpha: 1.0).CGColor;
        layer.addSublayer(bgLayer);
        layer.addSublayer(meterLayer);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let center = CGPoint(x:bounds.midX, y: bounds.midY)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth:CGFloat = 36;
        let startAngle: CGFloat = 3 * PI / 4
        let endAngle: CGFloat = PI / 4
        let path = UIBezierPath(arcCenter: CGPointZero,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true);
        
        bgLayer.position = center;
        bgLayer.path = path.CGPath;
        
        let angleDifference: CGFloat = 2 * PI - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(100);
        let outlineEndAngle = arcLengthPerGlass * CGFloat(score) + startAngle
        
        let path2 = UIBezierPath(arcCenter: CGPointZero,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true);
        
        meterLayer.position = center;
        meterLayer.path = path2.CGPath;

        
    }
    
    func updateAnimation(){
        if animating {
            meterLayer.addAnimation(MeterAnimation, forKey: "strokeEnd")
        }
        else {
            meterLayer.removeAnimationForKey("strokeEnd")
        }
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    

    @IBInspectable var score: Int = 0;
    @IBInspectable var bgColor:UIColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0);
    @IBInspectable var lineColor:UIColor = UIColor(red: 51/255.0, green: 255/255.0, blue: 153/255.0, alpha: 1.0);
    
    
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let arcWidth: CGFloat = 36
        let startAngle: CGFloat = 3 * PI / 4
        let endAngle: CGFloat = PI / 4
        
        let path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true);
        
        path.lineWidth = arcWidth;
        bgColor.setStroke();
        path.stroke();
        
        
        let angleDifference: CGFloat = 2 * PI - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(100);
        let outlineEndAngle = arcLengthPerGlass * CGFloat(score) + startAngle
        
        let path2 = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true);
        
        path2.lineWidth = arcWidth - 5;
        lineColor.setStroke();
        path2.stroke();
        
        
    }
    
    func updateAnimation(){
        let MeterAnimation: CAAnimation = {
            let animation = CABasicAnimation(keyPath: "strokeEnd");
            animation.fromValue = 0;
            animation.toValue = 1;
            animation.duration = 1;
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
            animation.repeatCount = 1;
            return animation;
        }()
        
        self.layer.addAnimation(MeterAnimation, forKey: "strokeEnd");
    }*/
}
