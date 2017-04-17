//
//  ViewController.swift
//  IntroApp
//
//  Created by Ada Chmielewska on 01.02.2017.
//  Copyright © 2017 All in mobile. All rights reserved.
//

import UIKit
import Presentation
import Hue
import Cartography

class IntroViewController: PresentationController, PresentationControllerDelegate {
    
    private let nextButton = UIButton()
    private let skipButton = UIButton()
    private let lastSlide = 4
    private var arrowPosition = Position(left: 0.5, top: 0.25)
    private let jumpValue: CGFloat = 0.03
    private let slideTitles = [
        NSLocalizedString("Hi... ", comment: ""),
        NSLocalizedString("Hello!", comment: ""),
        NSLocalizedString(":) :) :) ", comment: ""),
        NSLocalizedString("Welcome :)", comment: ""),
        ]
    private let currentDeviceModel = PhoneSize.currentDevice()
    private var imageWithGradient: BackgroundImage?
    private var gradientColors = [[UIColor.intro1a(), UIColor.intro1b()], [UIColor.intro2a(), UIColor.intro2b()], [UIColor.intro3a(), UIColor.intro3b()], [UIColor.intro4a(), UIColor.intro4b()]].map{ array in
        array.map { $0.cgColor }
    }
    private var previousGradientColor: [CGColor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationDelegate = self
        setNavigationTitle = false
        configureSlides()
        configureBackground()
        showPageControl = true
        showBottomLine = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        goTo(0) //to resolve problem with dissappearing dots when arrow is animating
    }
    
    private func configureSlides() {
        let arrows = configureArrows()
        let slides = addContent(titles: configureTitles(), arrows: arrows)
        self.view.layoutIfNeeded()
        animate(contents: arrows)
        add(slides)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        add([signUpViewController])
    }
    
    private func configureArrows() -> [Content] {
        let image = UIImage(named: "selected")
        return zip([image, image, image], [UIColor.dancrBlue(), UIColor.dancrPink(), UIColor.dancrGreen()]).map { image, color -> Content in
            let tintedImage = image?.tintedImageWithColor(color, blendMode: CGBlendMode.plusDarker)
            let arrowView = UIImageView(image: scaleImage(image: tintedImage, scale: currentDeviceModel.arrowScale()))
            return Content(view: arrowView, position: arrowPosition)
        }
    }
    
    private func scaleImage(image: UIImage?, scale: CGFloat) -> UIImage {
        if let image = image, let cgImage = image.cgImage {
            return UIImage(cgImage: cgImage, scale: image.scale * scale, orientation: image.imageOrientation)
        }
        return UIImage()
    }
    
    private func addContent(titles: [Content], arrows: [Content]) -> [SlideController] {
        var slides = [SlideController]()
        for index in 0..<lastSlide {
            let controller = SlideController(contents: [])
            controller.add(contents: [titles[index]])
            if index > 0 {
                if let arrow = arrows[safe: index - 1] {
                    controller.add(content: arrow)
                }
            }
            slides.append(controller)
        }
        return slides
    }
    
    private func configureTitles() -> [Content] {
        return slideTitles.map { title -> Content in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 550, height: 200))
            label.attributedText = NSAttributedString(string: title, attributes: fontAtributtes())
            return Content(view: label, position: currentDeviceModel.titlePosition())
        }
    }
    
    private func fontAtributtes() ->  [String : Any]? {
        let font = UIFont.oswaldLight(35)
        let color = UIColor.white
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        return [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
                NSParagraphStyleAttributeName: paragraphStyle]
    }
    
    private func animate(contents: [Content]) {
        animateDown(contents: contents)
    }
    
    private func  animateDown(contents: [Content]) {
        for content in contents {
            content.position = Position(left: arrowPosition.left, top: arrowPosition.top - jumpValue)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.view.layoutIfNeeded()
        },completion: { (_) -> Void in
            self.animateUp(contents: contents)
        })
    }
    
    private func animateUp(contents: [Content]) {
        for content in contents {
            content.position = Position(left: arrowPosition.left, top: arrowPosition.top + jumpValue)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.view.layoutIfNeeded()
        },completion: { (_) -> Void in
            self.animateDown(contents: contents)
        })
    }
    
    private func configureBackground() {
        let backgroundImages = self.backgroundImages()
        var contents = [Content]()
        for backgroundImage in backgroundImages {
            let imageView = backgroundImage.gradientView
            if let position = backgroundImage.positionAt(0) {
                contents.append(Content(view: imageView, position: position, centered: false))
            }
        }
        addToBackground(contents)
        addTransitionAnimation(backgroundImages: backgroundImages, contents: contents)
    }
    
    private func backgroundImages() -> [BackgroundImage] {
        let scale = currentDeviceModel.backgroundScale()
        imageWithGradient = BackgroundImage(image: scaleImage(image: UIImage(named: "buildings_02"), scale: scale), left: 0.0, top: 0.0, speed: -0.12, gradientColors: gradientColors[0])
        return [
            BackgroundImage(image: scaleImage(image: UIImage(named: "buildings_01"), scale: scale), left: 0.0, top: 0.0, speed: -0.5),
            imageWithGradient ?? BackgroundImage(image: scaleImage(image: UIImage(named: "buildings_02"), scale: scale), left: 0.0, top: 0.0, speed: -0.12),
            BackgroundImage(image: scaleImage(image: UIImage(named: "buildings_03"), scale: scale), left: 0.0, top: 0.0, speed: -0.08)
        ]
    }
    
    private func addTransitionAnimation(backgroundImages: [BackgroundImage], contents: [Content]) {
        for row in 1...4 {
            for (column, backgroundImage) in backgroundImages.enumerated() {
                if let position = backgroundImage.positionAt(row), let content = contents[safe: column] {
                    addAnimation(TransitionAnimation(content: content, destination: position,
                                                     duration: 2.0, damping: 1.0), forPage: row)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = pageControl {
            configureBottomSection()
        }
    }
    
    private func configureBottomSection() {
        configureSkipButton()
        configureNextButton()
        self.view.layoutIfNeeded()
    }
    
    private func configureSkipButton() {
        guard let pageControl = pageControl else { return }
        skipButton.setTitle(NSLocalizedString("SKIP", comment: ""), for: .normal)
        skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
        pageControl.addSubview(skipButton)
        constrain(pageControl, skipButton, block: {view, button in
            button.left == view.left + 40
            button.centerY == view.centerY
        })
    }
    
    @objc private func skip() {
        goTo(lastSlide)
    }
    
    private func configureNextButton() {
        guard let pageControl = pageControl else { return }
        nextButton.setTitle(NSLocalizedString(">", comment: ""), for: .normal)
        nextButton.addTarget(self, action: #selector(moveForward), for: .touchUpInside)
        pageControl.addSubview(nextButton)
        constrain(pageControl, nextButton, block: {view, button in
            button.right == view.right - 35
            button.centerY == view.centerY
        })
    }
    
    public func presentationController(_ presentationController: Presentation.PresentationController, didSetViewController viewController: UIViewController, atPage page: Int){
        if let gradientColorValue = gradientColors[safe: page] {
            imageWithGradient?.gradient?.changeGradientColor(fromColors: previousGradientColor, toColors: gradientColorValue)
            previousGradientColor = gradientColorValue
        } else {
            if let colors = gradientColors.last {
                imageWithGradient?.gradient?.addGradientLayer(colors: colors)
            }
            pageControl?.isHidden = true
            enableSwipe = false
        }
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

private struct BackgroundImage {
    
    private var name: String?
    private let left: CGFloat
    private let top: CGFloat
    private let speed: CGFloat
    var image: UIImage
    var gradient: CAGradientLayer?
    var gradientView: UIImageView {
        let imageView = UIImageView(image: image)
        if let gradient = gradient {
            imageView.layer.addSublayer(gradient)
        }
        return imageView
    }
    
    init(image: UIImage, left: CGFloat, top: CGFloat, speed: CGFloat, gradientColors: [CGColor]? = nil) {
        self.image = image
        self.left = left
        self.top = top
        self.speed = speed
        if let color1 = gradientColors?[0], let color2 = gradientColors?[1] {
            let gradientLayer = CAGradientLayer.create(upColor: color1, bottomColor: color2, size: image.size)
            gradient = gradientLayer
        }
    }
    
    func positionAt(_ index: Int) -> Position? {
        var position: Position?
        if index == 0 || speed != 0.0 {
            let currentLeft = left + CGFloat(index) * speed
            position = Position(left: currentLeft, top: top)
        }
        return position
    }
}

private extension PhoneSize {
    
    func backgroundScale() -> CGFloat {
        switch self {
        case .inches4_7:
            return 0.85
        case .inches4, .inches3_5:
            return 0.99
        case .inches5_5:
            return 0.77
        }
    }
    
    func arrowScale() -> CGFloat {
        switch self {
        case .inches4_7:
            return 0.5
        case .inches4, .inches3_5:
            return 0.7
        case .inches5_5:
            return 0.4
        }
    }
    
    func titlePosition() -> Position {
        switch self {
        case .inches3_5:
            return Position(left: 0.5, top: 0.90)
        default:
            return Position(left: 0.5, top: 0.85)
        }
    }
}


