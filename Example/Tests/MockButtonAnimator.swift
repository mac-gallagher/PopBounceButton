//
//  MockButtonAnimator.swift
//  PopBounceButton_Tests
//
//  Created by Mac Gallagher on 1/11/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

@testable import PopBounceButton

class MockButtonAnimator: ButtonAnimatable {
    var didApplyScaleAnimation: Bool = false
    var scaleToValue: CGPoint?
    var scaleDelay: TimeInterval?
    var scaleDuration: TimeInterval?
    
    func applyScaleAnimation(to view: UIView, toValue: CGPoint, delay: TimeInterval, duration: TimeInterval) {
        didApplyScaleAnimation = true
        scaleToValue = toValue
        scaleDelay = delay
        scaleDuration = duration
    }
    
    var didApplySpringScaleAnimation: Bool = false
    var springScaleToValue: CGPoint?
    var springBounciness: CGFloat?
    var springSpeed: CGFloat?
    var springInitialVelocity: CGPoint?
    var springDelay: TimeInterval?
    
    func applySpringScaleAnimation(to view: UIView, fromValue: CGPoint, toValue: CGPoint, springBounciness: CGFloat, springSpeed: CGFloat, initialVelocity: CGPoint, delay: TimeInterval) {
        didApplySpringScaleAnimation = true
        springScaleToValue = toValue
        self.springBounciness = springBounciness
        self.springSpeed = springSpeed
        springInitialVelocity = initialVelocity
        springDelay = delay
    }
}
