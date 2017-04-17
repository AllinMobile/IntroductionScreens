//
//  UIImage+Tint.swift
//  IntroApp
//
//  Created by Ada Chmielewska on 01.02.2017.
//  Copyright © 2017 All in mobile. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageTintedWithColor(_ color:UIColor) -> UIImage {
        return tintedImageWithColor(color, blendMode: CGBlendMode.luminosity)
    }
    
    func tintedImageWithColor(_ tintColor:UIColor, blendMode:CGBlendMode) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        tintColor.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        if blendMode !=  CGBlendMode.luminosity {
            self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        }
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
}
