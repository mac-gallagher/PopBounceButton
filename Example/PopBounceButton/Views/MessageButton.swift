//
//  Messagebutton.swift
//  PopBounceButton_Example
//
//  Created by Mac Gallagher on 12/1/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import PopBounceButton

class MessageButton: PopBounceButton {
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let greenColor = UIColor(red: 39/255, green: 216/255, blue: 91/255, alpha: 1).cgColor
        let tealColor = UIColor(red: 30/255, green: 228/255, blue: 188/255, alpha: 1).cgColor
        gradient.colors = [greenColor, tealColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()
    
    override init() {
        super.init()
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        springSpeed = 15
        springBounciness = 16
        springVelocity = 2
        longPressScaleFactor = 0.9
        layer.masksToBounds = true
        adjustsImageWhenHighlighted = false
        
        setTitle("MESSAGES", for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        setImage(UIImage(named: "envelope")?.withRenderingMode(.alwaysOriginal), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 15, left: -12, bottom: 15, right: 0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = bounds.height / 2
        gradientLayer.frame = bounds
    }
}
