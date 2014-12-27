//
//  BarChart.swift
//  SwiftAnimate
//
//  Created by Andrew Rangel on 11/17/14.
//  Copyright (c) 2014 Andrew Rangel. All rights reserved.
//

import UIKit

class BarChart: NSObject {
    var barColor:UIColor?
    var barColorArray:[UIColor]?
    
    var xAndYAxisLine:Bool = false
    var noAnimation:Bool = false
    let padding:CGFloat = 10
    
    func configureChartFor(values:[Int], andView view:UIImageView) {
        
        let numberOfBars:Int = values.count
        
        // Pad the right side 1% by subtracting 1%
        let barWidth = (view.bounds.size.width / CGFloat(numberOfBars)) - (view.bounds.size.width * 0.01)
        let adjustedBarWidth = barWidth * 0.90
        
        let maxBarHeight = view.bounds.size.height - 10
        
        let numMax = values.reduce(Int.min, { max($0, $1) })
        let numMin = values.reduce(Int.max, { min($0, $1) })
        
        let maxIndex = find(values, numMax)
        
        for (var index:Int = 0; index < values.count; index++) {
            
            let variableBarX = (barWidth / 2) + (barWidth * CGFloat(index))
            
            
            if (index == maxIndex) {
                
                // We want to use padding to limit the chart from drawing to the bounds of the view
                createLine(CGPointMake(variableBarX + padding, maxBarHeight),
                    endPoint: CGPointMake(variableBarX + padding, padding),
                    barWidth: adjustedBarWidth,
                    view:view,
                    index:index,
                    valuesCount:values.count)
                
            } else {
                let a:CGFloat = 0 // view origin
                let b:CGFloat = maxBarHeight // view height
                
                let min:CGFloat = CGFloat(values[index])
                let max:CGFloat = CGFloat(numMax)
                
                let x = max
                
                let maxBarY = (((b-a) * (x - min)) / (max - min)) + a
                
                let percentageOfMaxValue = min / max
                
                let heightOfMin = percentageOfMaxValue * maxBarY
                
                // padding subtracted to even out the percentage of the bars, since the max line is limited by padding
                // remember everything is upside down
                createLine(CGPointMake(variableBarX + padding, maxBarY),
                    endPoint: CGPointMake(variableBarX + padding, maxBarY - heightOfMin + padding),
                    barWidth:adjustedBarWidth,
                    view:view,
                    index:index,
                    valuesCount:values.count)
            }
            
        }
        
    }
    
    
    func createLine(startPoint:CGPoint, endPoint:CGPoint, barWidth:CGFloat, view:UIImageView, index:Int, valuesCount:Int) {
        
        let linePath:UIBezierPath = UIBezierPath()
        linePath.moveToPoint(startPoint)
        linePath.addLineToPoint(endPoint)
        
        var shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.CGPath
        

        
        if (barColorArray != nil) {
            if (barColorArray!.count == valuesCount) {
                shapeLayer.strokeColor = barColorArray![index].CGColor
            } else {
                shapeLayer.strokeColor = UIColor.blackColor().CGColor
            }
        } else {
            if (barColor != nil) {
                shapeLayer.strokeColor = barColor!.CGColor
                
            } else {
                shapeLayer.strokeColor = UIColor.blackColor().CGColor
                
            }
        }
        
        shapeLayer.lineWidth = barWidth
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineCap = kCALineJoinRound
        
        view.layer.addSublayer(shapeLayer)
        
        if (noAnimation) {
            
        } else {
            animate(shapeLayer)

        }
    }
    
    
    func createLineForView(startPoint:CGPoint, endPoint:CGPoint, barWidth:CGFloat, view:UIView, index:Int, valuesCount:Int) {
        
        let linePath:UIBezierPath = UIBezierPath()
        linePath.moveToPoint(startPoint)
        linePath.addLineToPoint(endPoint)
        
        var shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.CGPath
        
        
        
        if (barColorArray != nil) {
            if (barColorArray!.count == valuesCount) {
                shapeLayer.strokeColor = barColorArray![index].CGColor
            } else {
                shapeLayer.strokeColor = UIColor.blackColor().CGColor
            }
        } else {
            if (barColor != nil) {
                shapeLayer.strokeColor = barColor!.CGColor
                
            } else {
                shapeLayer.strokeColor = UIColor.blackColor().CGColor
                
            }
        }
        
        shapeLayer.lineWidth = barWidth
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineCap = kCALineJoinRound
        
        view.layer.addSublayer(shapeLayer)
        
        if (noAnimation) {
            
        } else {
            animate(shapeLayer)
            
        }
    }
    
    func animate(progressLine:CAShapeLayer) {
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 1.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        progressLine.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
    }
}
