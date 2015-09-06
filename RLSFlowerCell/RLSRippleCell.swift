//
//  RLSRippleCell.swift
//  RLSRippleCell
//
//  Copyright 2015 RECRUIT LIFESTYLE CO., LTD.
//

import UIKit

class RLSRippleCell: UITableViewCell {
    var targetColor = UIColor(red: 101.0/255.0, green: 198.0/255.0, blue: 187.0/255.0, alpha: 0.9)
    var targetBackGroundColor = UIColor(red: 200.0/255.0, green: 247.0/255.0, blue: 197.0/255.0, alpha: 1.0)
    var showDuration: NSTimeInterval!
    private var touchedPoint = CGPointZero
    private var targetView = UIView()
    private var targetBackGroundView = UIView()
    private var isFinishBackgroundAnimation = true
    private var isFinishTargetAnimaiton = true
    var radiusSmallLength = CGFloat(0.0)
    var radiusLargeLength = CGFloat(0.0)

    
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
        if(isFinishTargetAnimaiton && isFinishBackgroundAnimation){
            isFinishBackgroundAnimation = false
            isFinishTargetAnimaiton = false
            animationWithCircleStart()
        }
        
        super.touchesEnded(touches, withEvent: event)
    }
    
    private func setLayout(){
        targetBackGroundView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        targetBackGroundView.clipsToBounds = true
        targetBackGroundView.layer.masksToBounds = true
        backgroundView = targetBackGroundView
        self.textLabel?.backgroundColor = UIColor.clearColor()
        touchedPoint = self.contentView.center
        showDuration = 0.6
        self.layer.masksToBounds = true
        radiusSmallLength = self.frame.size.height * 5
        radiusLargeLength = self.frame.size.width * 10
    }
    
    func animationWithCircleStart(){
        showTargetView()
        showFadeBackgroundIn()
    }
    
    func animationWithCirleEnd(){
        self.removeFadeBackgroundOut()
        self.removeTargetView()
    }
    
    private func showTargetView(){
        targetView = UIView(frame: CGRectMake(0, 0, radiusLargeLength, radiusLargeLength))
        targetView.center = touchedPoint
        targetView.layer.cornerRadius = radiusLargeLength / 2
        targetView.layer.masksToBounds = true
        targetView.backgroundColor = targetColor
        self.selectedBackgroundView.addSubview(targetView)
        
        targetView.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(showDuration,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.targetView.center = self.touchedPoint
                self.targetView.transform = CGAffineTransformIdentity
        }, completion: nil)
    }
    
    private func removeTargetView(){
        UIView.animateWithDuration(showDuration,
            delay: 0, options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.targetView.alpha = 0.0
                self.targetView.layer.cornerRadius = self.frame.size.width / 3
                self.targetView.frame = CGRectMake(self.touchedPoint.x - self.radiusLargeLength / 2, self.touchedPoint.y - self.radiusLargeLength / 2, self.radiusLargeLength, self.radiusLargeLength)
            }) { (animated) -> Void in
                self.targetView.removeFromSuperview()
                self.isFinishTargetAnimaiton = true
        }
    }
    
    private func showFadeBackgroundIn(){
        targetBackGroundView.backgroundColor = targetBackGroundColor
        targetBackGroundView.alpha = 0.0
        UIView.animateWithDuration(showDuration, animations: { () -> Void in
            self.targetBackGroundView.alpha = 1.0
        }) { (animated) -> Void in
            self.animationWithCirleEnd()

        }
    }
    
    private func removeFadeBackgroundOut(){
        self.targetBackGroundView.alpha = 0.0
        self.isFinishBackgroundAnimation = true
    }

}
