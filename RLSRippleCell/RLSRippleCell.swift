//
//  RLSRippleCell.swift
//
//  Created by Nari on 2015/08/19.
//  Copyright (c) 2015年 nari. All rights reserved.
//


import UIKit

class RLSRippleCell: UITableViewCell {
    private var rippleView: UIView!
    private var touchedPoint: CGPoint!
    private var backgroundRippleView:UIView!
    private var isAnimation = false
    var radiusSmallLength = CGFloat(0.0)
    var radiusLeargeLength = CGFloat(0.0)
    var rippleColor = UIColor(red: 101.0/255.0, green: 198.0/255.0, blue: 187.0/255.0, alpha: 0.9)
    var backgroundRippleColor = UIColor(red: 200.0/255.0, green: 247.0/255.0, blue: 197.0/255.0, alpha: 1.0)
    var showDuration = 0.6
    
    
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
        backgroundRippleView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        backgroundRippleView.clipsToBounds = true
        backgroundRippleView.layer.masksToBounds = true
        backgroundView = backgroundRippleView
        touchedPoint = self.contentView.center
        self.layer.masksToBounds = true
        radiusSmallLength = self.frame.size.height * 5
        radiusLeargeLength = self.frame.size.width * 10
    }
    
    func animationWithCircleStart(){
        if(isAnimation){return}
        isAnimation = true
        showRippleView()
        showFadeBackgroundIn()
    }
    
    func animationWithCirleEnd(){
        self.removeFadeBackgroundOut()
        self.removeRippleView()
    }
    
    func showRippleView(){
        rippleView = UIView(frame: CGRectMake(0, 0, radiusLeargeLength, radiusLeargeLength))
        rippleView.center = touchedPoint
        rippleView.layer.cornerRadius = radiusLeargeLength / 2
        rippleView.layer.masksToBounds = true
        rippleView.backgroundColor = rippleColor
        self.selectedBackgroundView.addSubview(rippleView)
        
        rippleView.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(showDuration,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.rippleView.center = self.touchedPoint
                self.rippleView.transform = CGAffineTransformIdentity
            }, completion: nil)
        
    }
    
    func removeRippleView(){
        UIView.animateWithDuration(showDuration,
            delay: 0, options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.rippleView.alpha = 0.0
                self.rippleView.layer.cornerRadius = self.frame.size.width / 3
                self.rippleView.frame = CGRectMake(self.touchedPoint.x - self.radiusLeargeLength / 2, self.touchedPoint.y - self.radiusLeargeLength / 2, self.radiusLeargeLength, self.radiusLeargeLength)
            }) { (animated) -> Void in
                self.rippleView.removeFromSuperview()
                self.isAnimation = false
        }
    }
    
    func showFadeBackgroundIn(){
        backgroundRippleView.backgroundColor = backgroundRippleColor
        backgroundRippleView.alpha = 0.0
        UIView.animateWithDuration(showDuration, animations: { () -> Void in
            self.backgroundRippleView.alpha = 1.0
            }) { (animated) -> Void in
                self.animationWithCirleEnd()
        }
    }
    
    func removeFadeBackgroundOut(){
        self.backgroundRippleView.alpha = 0.0
    }
    
}
