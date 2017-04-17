//
//  PhoneSize.swift
//  IntroApp
//
//  Created by Ada Chmielewska on 01.02.2017.
//  Copyright © 2017 All in mobile. All rights reserved.
//

import Foundation
import UIKit

enum PhoneSize {
    
    case inches5_5
    case inches4_7
    case inches4
    case inches3_5
    
    private static let iPhone6Width: CGFloat = 375
    private static let iPhone5Height: CGFloat = 568
    
    static func currentDevice() -> PhoneSize {
        let screenSize = UIScreen.main.bounds
        switch screenSize {
        case _ where screenSize.width > iPhone6Width:
            return .inches5_5
        case _ where screenSize.width == iPhone6Width:
            return .inches4_7
        case _ where screenSize.height == iPhone5Height:
            return .inches4
        case _ where screenSize.height < iPhone5Height:
            return .inches3_5
        default:
            return .inches4_7
        }
    }
}
