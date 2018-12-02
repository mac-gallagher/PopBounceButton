//
//  PopAnimator+Helpers.swift
//  MGSwipeCards
//
//  Created by Mac Gallagher on 11/2/18.
//

import pop

extension POPAnimator {
    static func applyScaleAnimation(to view: UIView, toValue: CGPoint, delay: TimeInterval = 0, duration: TimeInterval) {
        guard let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY) else { return }
        scaleAnimation.duration = duration
        scaleAnimation.toValue = toValue
        scaleAnimation.beginTime = CACurrentMediaTime() + delay
        view.pop_add(scaleAnimation, forKey: POPAnimator.scaleKey)
    }
    
    static func applySpringScaleAnimation(to view: UIView, fromValue: CGPoint, toValue: CGPoint, springBounciness: CGFloat, springSpeed: CGFloat, initialVelocity: CGPoint, delay: TimeInterval = 0) {
        guard let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY) else { return }
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.beginTime = CACurrentMediaTime() + delay
        scaleAnimation.springBounciness = springBounciness
        scaleAnimation.springSpeed = springSpeed
        scaleAnimation.velocity = initialVelocity
        view.pop_add(scaleAnimation, forKey: POPAnimator.springScaleKey)
    }
}

extension POPAnimator {
    static var scaleKey = "POPScaleAnimation"
    static var springScaleKey = "springScaleAnimation"
}
