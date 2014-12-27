//
//  Extensions.swift
//  FitPay
//
//  Created by Andrew Rangel on 11/15/14.
//  Copyright (c) 2014 Andrew Rangel. All rights reserved.
//

import UIKit

class Extensions: NSObject {
   
}

extension Double {
    func degreesToRadians() -> CGFloat {
        var angle = self
        return CGFloat(angle / 180.0 * M_PI)
    }
    
    func convertToDisplayString() -> String {
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        let number = Int(self)
        return formatter.stringFromNumber(number)!
    }
}

extension Int {
    func convertToDisplayString() -> String {
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        let number = self
        return formatter.stringFromNumber(number)!
    }
}
