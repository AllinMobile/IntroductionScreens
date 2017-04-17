//
//  UIFont.swift
//  IntroApp
//
//  Created by Ada Chmielewska on 01.02.2017.
//  Copyright © 2017 All in mobile. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func helveticaLight(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Helvetica Neue", size: size){
            return font
        }
        assertionFailure()
        return systemFont(ofSize: size)
    }
    
    class func oswaldLight(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Oswald", size: size) {
            return font
        }
        assertionFailure()
        return systemFont(ofSize: size)
    }
    
    class func oswaldRegular(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Oswald Regular", size: size) {
            return font
        }
        assertionFailure()
        return systemFont(ofSize: size)
    }
    
}

