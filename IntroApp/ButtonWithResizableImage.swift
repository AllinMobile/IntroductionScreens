//
//  ButtonWithResizableImage.swift
//  IntroApp
//
//  Created by Ada Chmielewska on 01.02.2017.
//  Copyright © 2017 All in mobile. All rights reserved.
//

import UIKit

class ButtonWithResizableImage : UIButton {
    
    @IBInspectable var imageName: String? {
        didSet {
            resizableBackgroundImage()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resizableBackgroundImage() {
        let myInsets : UIEdgeInsets = UIEdgeInsetsMake(20 ,10, 20, 10)
        if let imageName = imageName {
            self.setBackgroundImage(UIImage(named: imageName)?.resizableImage(withCapInsets: myInsets), for: UIControlState())
        }
    }
}
