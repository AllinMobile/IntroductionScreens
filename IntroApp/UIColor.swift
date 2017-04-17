//
//  UIColor.swift
//  IntroApp
//
//  Created by Ada Chmielewska on 01.02.2017.
//  Copyright © 2017 All in mobile. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    
    class func dancrPurple() -> UIColor {
        return UIColor(red:0.31, green:0.26, blue:0.4, alpha:1.0)
    }
    
    class func dancrBlue() -> UIColor {
        return UIColor(red:0.26, green:0.51, blue:0.62, alpha:1.0)
    }
    
    class func dancrGreen() -> UIColor {
        return UIColor(red:0.00, green:0.68, blue:0.67, alpha:1.0)
    }
    
    class  func dancrPink() -> UIColor {
        return UIColor(red:0.78, green:0.45, blue:0.52, alpha:1.0)
    }
    
    class func intro1a() -> UIColor {
        return UIColor(hex: "dbae6f").alpha(0)
    }
    
    class func intro1b() -> UIColor {
        return UIColor(hex: "39b89f").alpha(0.75)
    }
    
    class func intro2a() -> UIColor {
        return UIColor(hex: "39b89f").alpha(0.75)
    }
    
    class func intro2b() -> UIColor {
        return UIColor(hex: "39b89f").alpha(0)
    }
    
    class func intro3a() -> UIColor {
        return UIColor(hex: "298fbf").alpha(0.75)
    }
    
    class func intro3b() -> UIColor {
        return UIColor(hex: "39b89f").alpha(0)
    }
    
    class func intro4a() -> UIColor {
        return UIColor(hex: "4d3b6c").alpha(0.75)
    }
    
    class func intro4b() -> UIColor {
        return UIColor(hex: "39b89f").alpha(0)
    }
}
