//
//  CAGradientLayer+Gradient.swift
//  IntroApp
//
//  Created by Ada Chmielewska on 01.02.2017.
//  Copyright © 2017 All in mobile. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    static func create(upColor: CGColor, bottomColor: CGColor, size: CGSize) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = size
        gradientLayer.colors = [upColor, bottomColor]
        return gradientLayer
    }
    
    func changeGradientColor(fromColors: [CGColor]?, toColors: [CGColor]) {
        colors = toColors
        add(colorChangeAnimation(fromColors: fromColors, toColors: toColors), forKey: "colorChange")
    }
    
    func colorChangeAnimation(fromColors: [CGColor]?, toColors: [CGColor]) -> CABasicAnimation {
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.fromValue = fromColors
        colorChangeAnimation.toValue = toColors
        colorChangeAnimation.duration = 1.0
        return colorChangeAnimation
    }
    
    func addGradientLayer(colors: [CGColor]) {
        guard let upColor = colors[0].copy(alpha: 0.0), let bottomColor = colors[1].copy(alpha: 0.0) else { return }
        let extraLayer = CAGradientLayer.create(upColor: upColor, bottomColor: bottomColor, size: bounds.size)
        addSublayer(extraLayer)
        extraLayer.changeGradientColor(fromColors: [upColor,bottomColor], toColors: colors)
    }
}
