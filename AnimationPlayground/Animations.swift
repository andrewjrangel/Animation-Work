//
//  Animations.swift
//  FitPay
//
//  Created by Andrew Rangel on 11/15/14.
//  Copyright (c) 2014 Andrew Rangel. All rights reserved.
//

import UIKit

class Animations: AnimateView {
    var view:UIView = UIView()
    var ovalRect:CGRect = CGRect()
    var ovalEndPoint:CGFloat = CGFloat()
    var lineColor:UIColor = UIColor()
    var bkgLineColor:UIColor = UIColor()
    
    var lineWidth:CGFloat?
    var startAngle:Double?
    
    let animate:AnimateView = AnimateView()
    
    convenience init(setView:UIView, Rect rect:CGRect, LineColor color:UIColor, BackgroundLineColor backgroundLineColor:UIColor, LineWidth width:CGFloat?, StartAngle angle:Double?) {
        self.init()
        view = setView
        ovalRect = rect
        lineColor = color
        bkgLineColor = backgroundLineColor
        lineWidth = width
        startAngle = angle
    }
    
    func createCircleChartWithPercentage(percent:Double) {
        self.clearView()
        
        var percentage:Double = (percent * 360)
        animateChart(percentage)
    }
    
    func clearView() {
        self.view.layer.sublayers = nil
    }
    
    func animateChart(endPoint:Double) {
        ovalEndPoint = endPoint.degreesToRadians()
        
        var ovalStartAngle:CGFloat = CGFloat()
        var ovalEndAngle:CGFloat = CGFloat()
        
        if (startAngle != nil) {
            ovalStartAngle = startAngle!.degreesToRadians()
            ovalEndAngle = ovalEndPoint + startAngle!.degreesToRadians()
        } else {
            ovalStartAngle = 0.00.degreesToRadians()
            ovalEndAngle = ovalEndPoint
        }
        
        let backgroundStartAngle = 0.00.degreesToRadians()
        let backgroundEndAngle = 360.00.degreesToRadians()
        
        let ovalPath = UIBezierPath()
        
        let backgroundPath = UIBezierPath()
        
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: ovalStartAngle,
            endAngle: ovalEndAngle,
            clockwise: true)
        
        let progressLine:CAShapeLayer = createLineWithColor(lineColor, andPath: ovalPath)
        
        backgroundPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)),
            radius: CGRectGetWidth(ovalRect) / 2,
            startAngle: backgroundStartAngle,
            endAngle: backgroundEndAngle,
            clockwise: true)
        
        let backgroundLine:CAShapeLayer = createLineWithColor(bkgLineColor, andPath: backgroundPath)
        
        self.view.layer.addSublayer(backgroundLine)
        self.view.layer.addSublayer(progressLine)
        drawLine(progressLine)
        
    }
    

    
    func createLineWithColor(color:UIColor, andPath path:UIBezierPath) -> CAShapeLayer {
        let progressLine = CAShapeLayer()
        progressLine.path = path.CGPath
        progressLine.strokeColor = color.CGColor
        progressLine.fillColor = UIColor.clearColor().CGColor
        
        if (lineWidth? != nil) {
            progressLine.lineWidth = lineWidth!
            
        } else {
            progressLine.lineWidth = 10.0
            
        }
        progressLine.lineCap = kCALineCapButt
        
        return progressLine
    }
}
