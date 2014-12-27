//
//  ViewController.swift
//  AnimationPlayground
//
//  Created by AndrewJRangel on 11/24/14.
//  Copyright (c) 2014 AndrewJRangel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet var monthlyStepsView:UIImageView!
    var monthlyTotalSteps:Double = Double()
    var monthlySteps:Double = Double()
    
    @IBOutlet var weeklyStepsView:UIImageView!
    var weeklyTotalSteps:Double = Double()
    var weeklySteps:Double = Double()
    
    @IBOutlet var dailyStepsView:UIImageView!
    var dailyTotalSteps:Double = Double()
    var dailySteps:Double = Double()
    
    @IBOutlet var lazerView:UIView!
    
    @IBOutlet var intouchView:UIView!
    @IBOutlet var backgroundImageView:UIImageView!
    
    let animate:AnimateView = AnimateView()
    
    var monthlyColor:UIColor = UIColor(
        red: 185/255.0,
        green: 76/255.0,
        blue: 118/255.0,
        alpha: 1)
    
    var weeklyColor:UIColor = UIColor(
        red: 60/255.0,
        green: 111/255.0,
        blue: 135/255.0,
        alpha: 1.0)
    
    var dailyColor:UIColor = UIColor(
        red: 141/255.0,
        green: 194/255.0,
        blue: 80/255.0,
        alpha: 1.0)
    
    
    
    @IBOutlet var barChartView:UIImageView!
    let valuesInOrder:[Int] = [3456, 6593, 3456, 8493, 4456]
    let chartColors:[UIColor] = [UIColor.redColor(), UIColor.greenColor(), UIColor.cyanColor(), UIColor.yellowColor(), UIColor.purpleColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reloadView()
        
        
        // Optional Parameters //
        
        //barChart.barColor = UIColor.redColor()
        //barChart.noAnimation = true

        
        
        buildIntouchView()
    }
    
    @IBAction func addLazer() {
        buildLazer(lazerView)

    }
    
    @IBAction func removeLazer() {
        
        if (lazerView.layer.sublayers != nil) {
            lazerView.layer.sublayers = nil
        }
    }
    
    @IBAction func addBarChart() {
        let barChart:BarChart = BarChart()
        barChart.barColorArray = chartColors
        
        barChart.configureChartFor(valuesInOrder, andView: barChartView)
    }
    
    @IBAction func removeBarChart() {
        
        if (barChartView.layer.sublayers != nil) {
            barChartView.layer.sublayers = nil

        }
    }
    func buildLazer(view:UIView) {
        let barChart:BarChart = BarChart()
        barChart.barColor = UIColor.greenColor()
        barChart.noAnimation = true
        let fullLazer:UIBezierPath = UIBezierPath()
        let halfLazer:UIBezierPath = UIBezierPath()

        for (var index:Int = 0; index < Int(view.bounds.size.width / 10); index++) {
            
            let lazerLine:UIBezierPath = UIBezierPath()
            lazerLine.moveToPoint(CGPointMake(view.bounds.midX, view.bounds.midY))
            lazerLine.addLineToPoint(CGPointMake(CGFloat(index * 10), view.bounds.size.height))
            
            fullLazer.appendPath(lazerLine)
            
            let halfLine:UIBezierPath = UIBezierPath()
            halfLine.moveToPoint(CGPointMake(view.bounds.midX, view.bounds.midY))
            halfLine.addLineToPoint(CGPointMake(CGFloat(index * 10), 0))
            
            halfLazer.appendPath(halfLine)
        }
        
        var lazerLayer:CAShapeLayer = CAShapeLayer()
        lazerLayer.path = fullLazer.CGPath
        lazerLayer.strokeColor = UIColor.greenColor().CGColor
        
        view.layer.addSublayer(lazerLayer)
        
        let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 1.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        
        let animateStrokeBegin = CABasicAnimation(keyPath: "strokeBegin")
        animateStrokeBegin.duration = 1.0
        animateStrokeBegin.fromValue = 0.0
        animateStrokeBegin.toValue = 1.0
        
        let halfAnimate = CABasicAnimation(keyPath: "path")
        halfAnimate.duration = 2.0
        halfAnimate.toValue = halfLazer.CGPath
        lazerLayer.addAnimation(halfAnimate, forKey: "morph")
        
        let group:CAAnimationGroup = CAAnimationGroup()
        group.duration = 2.0
        group.repeatCount = 4
        group.autoreverses = true
        group.animations = [animateStrokeBegin, animateStrokeEnd, halfAnimate]
        
        lazerLayer.addAnimation(group, forKey: "allAnimations")
        
//        fullLazer.appendPath(halfLazer)
//        
//        var halfLayer:CAShapeLayer = CAShapeLayer()
//        lazerLayer.path = fullLazer.CGPath
//        lazerLayer.strokeColor = UIColor.greenColor().CGColor
//        
//        lazerImageView.layer.addSublayer(halfLayer)

    }
    
    func buildIntouchView() {
        let barChart:BarChart = BarChart()
        let intouchGreen = UIColor(red: 163/255, green: 206/255, blue: 41/255, alpha: 1)
        barChart.barColor = intouchGreen
        
        let imgViewPercent:CGFloat = intouchView.bounds.size.width / 5
        let circleAdjustY:CGFloat = intouchView.bounds.size.width / 9
        let innerPadding:CGFloat = intouchView.bounds.size.width / 10
        
        var barWidth:CGFloat = intouchView.bounds.size.width / 7
        
        let midPointLeft:CGPoint = CGPointMake(intouchView.bounds.midX - innerPadding, intouchView.bounds.midY)
        let midPointRight:CGPoint = CGPointMake(intouchView.bounds.midX + innerPadding, intouchView.bounds.midY)
        
        
        let intouchLogoPath:UIBezierPath = UIBezierPath()
        intouchLogoPath.moveToPoint(midPointLeft)
        intouchLogoPath.addLineToPoint(CGPointMake(0, 0))
        
        let line2:UIBezierPath = UIBezierPath()
        line2.moveToPoint(midPointLeft)
        line2.addLineToPoint(CGPointMake(0, intouchView.bounds.size.height))
        
        let line3:UIBezierPath = UIBezierPath()
        line3.moveToPoint(midPointRight)
        line3.addLineToPoint(CGPointMake(intouchView.bounds.size.width, 0))
        
        let line4:UIBezierPath = UIBezierPath()
        line4.moveToPoint(midPointRight)
        line4.addLineToPoint(CGPointMake(intouchView.bounds.size.width, intouchView.bounds.size.height))
        

        let topCircle:UIBezierPath = UIBezierPath(ovalInRect:
            CGRectMake(intouchView.bounds.midX - CGFloat(circleAdjustY), intouchView.bounds.size.height, imgViewPercent, imgViewPercent))
        
        let bottomCircle:UIBezierPath = UIBezierPath(ovalInRect:
            CGRectMake(intouchView.bounds.midX - CGFloat(circleAdjustY), (0 - imgViewPercent), imgViewPercent, imgViewPercent))
        
        intouchLogoPath.appendPath(line2)
        intouchLogoPath.appendPath(line3)
        intouchLogoPath.appendPath(line4)
        
        // This makes the cirlces really fat, could be used for clipping path
//        intouchLogoPath.appendPath(topCircle)
//        intouchLogoPath.appendPath(bottomCircle)
        
        topCircle.appendPath(bottomCircle)
        
        
        var shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.path = intouchLogoPath.CGPath
        shapeLayer.strokeColor = intouchGreen.CGColor
        shapeLayer.fillColor = intouchGreen.CGColor
        shapeLayer.lineWidth = barWidth
        shapeLayer.lineCap = kCALineJoinRound
        
        var shapeLayer2:CAShapeLayer = CAShapeLayer()
        shapeLayer2.path = topCircle.CGPath
        shapeLayer2.strokeColor = intouchGreen.CGColor
        shapeLayer2.fillColor = intouchGreen.CGColor
        
        intouchView.layer.addSublayer(shapeLayer)
        intouchView.layer.addSublayer(shapeLayer2)
    }
    
    @IBAction func bounceButtonPressed() {
        //bounceAnimation(intouchView)
        animate.popAnimation(intouchView)
    }
    
    @IBAction func rotateButtonPressed() {
        animate.rotateAnimation(intouchView)
    }
    

    
    func reloadView() {
        configureValues()
        configureViews()
        
    }
    
    func configureValues() {
        monthlyTotalSteps = 8700
        monthlySteps = 4000
        
        weeklyTotalSteps = 678
        weeklySteps = 236
        
        dailyTotalSteps = 120
        dailySteps = 60
    }
    
    func configureViews(){
        configureStepsAnimationWithSteps(monthlySteps,
            TotalSteps: monthlyTotalSteps,
            View: monthlyStepsView,
            LineColor: monthlyColor,
            
            BackgroundColor: UIColor(
                red: 124/255.0,
                green: 18/255.0,
                blue: 59/255.0,
                alpha: 0.2),
            LineWidth: CGFloat(20.0),
            StartAngle:nil)
        
        configureStepsAnimationWithSteps(weeklySteps,
            TotalSteps: weeklyTotalSteps,
            View: weeklyStepsView,
            LineColor: weeklyColor,
            
            BackgroundColor: UIColor(white: 0.5, alpha: 0.2),
            LineWidth: CGFloat(15.0),
            StartAngle: Double(25.0))
        
        configureStepsAnimationWithSteps(dailySteps,
            TotalSteps: dailyTotalSteps,
            View: dailyStepsView,
            LineColor: dailyColor,
            BackgroundColor: UIColor(white: 0.5, alpha: 0.2),
            LineWidth: CGFloat(10.0),
            StartAngle: Double(66.0))
    }
    
    
    func configureStepsAnimationWithSteps(steps:Double, TotalSteps totalSteps:Double, View view:UIView, LineColor color:UIColor, BackgroundColor backgroundColor:UIColor, LineWidth lineWidth:CGFloat?, StartAngle angle:Double?) {
        
        let animationClass = Animations(setView: view, Rect: CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height), LineColor: color, BackgroundLineColor: backgroundColor, LineWidth: lineWidth, StartAngle: angle)
        
        animationClass.clearView()
        animationClass.createCircleChartWithPercentage(steps/totalSteps)
    }
    
    func configureLabelForPercentage(label:UILabel, Steps steps:Double, TotalSteps totalSteps:Double, Color color:UIColor) {
        let percentage:Int = Int((steps / totalSteps) * 100)
        label.text = percentage.description + "%"
        label.textColor = color
    }
    
    func configureBarLabelForAngle(label:UILabel, Angle angle:Double) {
        let angle:Double = (M_PI * angle) / 180.0
        label.transform = CGAffineTransformMakeRotation(CGFloat(angle))
        label.layer.allowsEdgeAntialiasing = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}