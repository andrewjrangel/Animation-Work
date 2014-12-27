//
//  AnimateView.swift
//  AnimationPlayground
//
//  Created by AndrewJRangel on 11/26/14.
//  Copyright (c) 2014 AndrewJRangel. All rights reserved.
//

import UIKit

class AnimateView: NSObject {
    
    func bounceAnimation(view:UIView) {
        let duration : NSTimeInterval = 0.5
        let delay :NSTimeInterval = 0.2
        let damping : CGFloat = 0.3
        let textAnimationVelocity : CGFloat = 0.5
        
        
        UIView.animateWithDuration(duration,
            delay: delay,
            usingSpringWithDamping: damping,
            initialSpringVelocity: textAnimationVelocity,
            options: .Autoreverse,
            animations: {
                view.transform = CGAffineTransformMakeScale(1.1, 1.1)
            },
            completion: {success in
                view.transform = CGAffineTransformIdentity
        })
    }
    
    func rotateAnimation(view:UIView) {
        let duration = 2.0
        let delay = 0.0 // delay will be 0.0 seconds (e.g. nothing)
        let options = UIViewAnimationOptions.Autoreverse // change the timing curve to `ease-in ease-out`
        
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            view.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
            
            }, completion: { finished in
                view.transform = CGAffineTransformIdentity
        })
        
    }
    
    func popAnimation(view:UIView) {
        let duration : NSTimeInterval = 0.50
        let delay :NSTimeInterval = 0.0
        let damping : CGFloat = 0.75
        let textAnimationVelocity : CGFloat = 1.0
        
        
        UIView.animateWithDuration(duration,
            delay: delay,
            usingSpringWithDamping: damping,
            initialSpringVelocity: textAnimationVelocity,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                view.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: {success in
                UIView.animateWithDuration(duration,
                    delay: delay,
                    usingSpringWithDamping: damping,
                    initialSpringVelocity: textAnimationVelocity,
                    options: UIViewAnimationOptions.CurveEaseOut,
                    animations: {
                        view.transform = CGAffineTransformMakeScale(1.2, 1.2)
                    }, completion: {success in
                        UIView.animateWithDuration(duration,
                            delay: delay,
                            usingSpringWithDamping: damping,
                            initialSpringVelocity: textAnimationVelocity,
                            options: UIViewAnimationOptions.CurveEaseOut,
                            animations: {
                                view.transform = CGAffineTransformMakeScale(0.9, 0.9)
                            }, completion: {success in
                                UIView.animateWithDuration(duration,
                                    delay: delay,
                                    usingSpringWithDamping: damping,
                                    initialSpringVelocity: textAnimationVelocity,
                                    options: UIViewAnimationOptions.CurveEaseOut,
                                    animations: {
                                        view.transform = CGAffineTransformMakeScale(1, 1)
                                    }, completion: {success in
                                        view.transform = CGAffineTransformIdentity
                                })
                        })
                })
        })
    }
    
    
    func drawLine(progressLine:CAShapeLayer) {
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 2.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
    }
    
    func reverseDrawLine(progressLine:CAShapeLayer) {
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")

        animateStrokeEnd.duration = 2.0
        animateStrokeEnd.fromValue = 1.0
        animateStrokeEnd.toValue = 0.0
        
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke reverse animation")
    }
}
