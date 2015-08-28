//
//  RLSRippleCell.swift
//  RLSRippleCell
//
//  Created by nari on 2015/06/29.
//  Copyright (c) 2015年 Nari. All rights reserved.
//

import UIKit

class RLSRippleCell: UITableViewCell {
    var targetColor: UIColor!
    var targetBGColor: UIColor!
    var showDuration: NSTimeInterval!
    private var circleView: UIView!
    private var touchedPoint: CGPoint!
    private var bgView:UIView!
    var radiusSmallLength: CGFloat!
    var radiusLeargeLength: CGFloat!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
     override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        touchedPoint = touch.locationInView(self)
        super.touchesBegan(touches, withEvent: event)
    }

    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        animationWithCircleStart()
        super.touchesEnded(touches, withEvent: event)
    }
    
    func setLayout(){
        targetColor = UIColor(red: 101.0/255.0, green: 198.0/255.0, blue: 187.0/255.0, alpha: 0.9)
        targetBGColor = UIColor(red: 200.0/255.0, green: 247.0/255.0, blue: 197.0/255.0, alpha: 1.0)
        bgView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        bgView.clipsToBounds = true
        bgView.layer.masksToBounds = true
        backgroundView = bgView
        self.textLabel?.backgroundColor = UIColor.clearColor()
        touchedPoint = self.contentView.center
        showDuration = 0.6
        self.layer.masksToBounds = true
        radiusSmallLength = self.frame.size.height * 5
        radiusLeargeLength = self.frame.size.width * 10
    }
    
    func animationWithCircleStart(){
        showCircleView()
        showFadeBackgroundIn()
    }
    
    func animationWithCirleEnd(){
        self.removeFadeBackgroundOut()
        self.removeCircleView()
    }
    
    func showCircleView(){
        circleView = UIView(frame: CGRectMake(0, 0, radiusLeargeLength, radiusLeargeLength))
        circleView.center = touchedPoint
        circleView.layer.cornerRadius = radiusLeargeLength / 2
        circleView.layer.masksToBounds = true
        circleView.backgroundColor = targetColor
        self.selectedBackgroundView.addSubview(circleView)
        
        circleView.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(showDuration,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.circleView.center = self.touchedPoint
                self.circleView.transform = CGAffineTransformIdentity
        }, completion: nil)
        
    }
    
    func removeCircleView(){
        UIView.animateWithDuration(showDuration,
            delay: 0, options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.circleView.alpha = 0.0
                self.circleView.layer.cornerRadius = self.frame.size.width / 3
                self.circleView.frame = CGRectMake(self.touchedPoint.x - self.radiusLeargeLength / 2, self.touchedPoint.y - self.radiusLeargeLength / 2, self.radiusLeargeLength, self.radiusLeargeLength)
            }) { (animated) -> Void in
                self.circleView.removeFromSuperview()
        }
    }
    
    func showFadeBackgroundIn(){
        bgView.backgroundColor = targetBGColor
        bgView.alpha = 0.0
        UIView.animateWithDuration(showDuration, animations: { () -> Void in
            self.bgView.alpha = 1.0
        }) { (animated) -> Void in
            self.animationWithCirleEnd()
        }
    }
    
    func removeFadeBackgroundOut(){
        self.bgView.alpha = 0.0
    }

}
