//
//  PopBounceButton.swift
//  PopBounceButton
//
//  Created by Mac Gallagher on 5/25/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import pop

open class PopBounceButton: UIButton {
    //Spring Animation Settings
    open var springBounciness: CGFloat = 19
    open var springSpeed: CGFloat = 10
    open var springVelocity: CGFloat = 6
    open var cancelDuration: TimeInterval = 0.3
    
    //Long Press Animation Settings
    open var longPressScaleFactor: CGFloat = 0.7
    open var longPressScaleDuration: TimeInterval = 0.1
    open var minimumPressDuration: TimeInterval = 0.2
    
    private var isScaled: Bool = false
    private var longPressTimer: Timer = Timer()
    private var initialBounds: CGSize = .zero
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(handleTouchUpOutside), for: .touchUpOutside)
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        initialBounds = rect.size
    }
    
    @objc private func handleTouchDown() {
        longPressTimer = Timer.scheduledTimer(timeInterval: minimumPressDuration, target: self, selector: #selector(handleScale), userInfo: nil, repeats: false)
    }
    
    @objc private func handleScale() {
        pop_removeAllAnimations()
        POPAnimator.applyScaleAnimation(to: self, toValue: CGPoint(x: longPressScaleFactor, y: longPressScaleFactor), duration: longPressScaleDuration)
        isScaled = true
    }
    
    @objc private func handleTouchUpInside() {
        pop_removeAllAnimations()
        if isScaled {
            POPAnimator.applySpringScaleAnimation(to: self, toValue: .one, springBounciness: springBounciness, springSpeed: springSpeed, delay: 0.05)
        } else {
            let velocityFactor = -frame.width / initialBounds.width
            let velocity = CGSize(width: velocityFactor * springVelocity, height: velocityFactor * springVelocity)
            POPAnimator.applySpringScaleAnimation(to: self, fromValue: CGPoint(x: 0.999, y: 0.999), toValue: .one, springBounciness: springBounciness, springSpeed: springSpeed, initialVelocity: velocity)
        }
        longPressTimer.invalidate()
        isScaled = false
    }
    
    @objc private func handleTouchUpOutside() {
        POPAnimator.applyScaleAnimation(to: self, toValue: .one, duration: cancelDuration)
        longPressTimer.invalidate()
        isScaled = false
    }
}

extension CGPoint {
    static var one = CGPoint(x: 1, y: 1)
}
