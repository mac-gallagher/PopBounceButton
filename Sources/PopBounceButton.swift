//
//  PopBounceButton.swift
//  PopBounceButton
//
//  Created by Mac Gallagher on 5/25/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import pop

public protocol PopBounceButtonDelegate {
    
    func didTouchUpInside(onButton button: PopBounceButton)
    
    func didTouchUpOutside(onButton button: PopBounceButton)
    
}

public class PopBounceButton: UIControl {
    
    public var delegate: PopBounceButtonDelegate?
    
    private var button = UIButton(type: .custom)
    
    //MARK: - Spring Animation Settings
    
    public var springBounciness: CGFloat = 19
    
    public var springSpeed: CGFloat = 10
    
    public var springVelocity: CGFloat = 6
    
    public var cancelDuration: TimeInterval = 0.3
    
    //MARK: - Long Press Animation Settings
    
    public var scaleFactor: CGFloat = 0.7
    
    public var scaleDuration: TimeInterval = 0.1
    
    public var minimumPressDuration: TimeInterval = 0.2
    
    //MARK: - Title Configuration
    
    public var titleLabel: UILabel? {
        return button.titleLabel
    }
    
    public var title: String? {
        return button.title(for: .normal)
    }
    
    public func setTitle(_ title: String?) {
        button.setTitle(title, for: .normal)
    }
    
    public var attributedTitle: NSAttributedString? {
        return button.attributedTitle(for: .normal)
    }
    
    public func setAttributedTitle(_ title: NSAttributedString?) {
        button.setAttributedTitle(title, for: .normal)
    }
    
    public var titleColor: UIColor? {
        return button.titleColor(for: .normal)
    }
    
    public func setTitleColor(_ color: UIColor?) {
        button.setTitleColor(color, for: .normal)
    }
    
    public var titleShadowColor: UIColor? {
        return button.titleShadowColor(for: .normal)
    }
    
    public func setTitleShadowColor(_ color: UIColor?) {
        button.setTitleShadowColor(color, for: .normal)
    }
    
    //MARK: - Presentation Configuration
    
    public var backgroundImage: UIImage? {
        return button.backgroundImage(for: .normal)
    }
    
    public func setBackgroundImage(_ image: UIImage?) {
        return button.setBackgroundImage(image, for: .normal)
    }
    
    public var image: UIImage? {
        return button.image(for: .normal)
    }
    
    public func setImage(_ image: UIImage?) {
        button.setImage(image, for: .normal)
    }
    
    public override var backgroundColor: UIColor? {
        didSet {
            button.backgroundColor = backgroundColor
            super.backgroundColor = .clear
        }
    }
    
    //MARK: - Edge Insets Configuration
    
    public var contentEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            button.contentEdgeInsets = contentEdgeInsets
        }
    }
    
    public var titleEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            button.titleEdgeInsets = titleEdgeInsets
        }
    }
    
    public var imageEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            button.imageEdgeInsets = imageEdgeInsets
        }
    }
    
    //MARK: - Dimensions
    
    public func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        return button.backgroundRect(forBounds: bounds)
    }
    
    public func contentRect(forContentRect contentRect: CGRect) -> CGRect  {
        return button.contentRect(forBounds: contentRect)
    }
    
    public func titleRect(forContentRect contentRect: CGRect) -> CGRect  {
        return button.titleRect(forContentRect: contentRect)
    }
    
    public func imageRect(forContentRect contentRect: CGRect) -> CGRect  {
        return button.imageRect(forContentRect: contentRect)
    }
    
    //MARK: - Other Variables
    
    public var imageView: UIImageView? {
        return button.imageView
    }
    
    public override var layer: CALayer {
        return button.layer
    }
    
    //MARK: - Main Methods
    
    public init() {
        super.init(frame: CGRect.zero)
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
        backgroundColor = .white
        super.addSubview(button)
        button.isUserInteractionEnabled = false
        button.layer.masksToBounds = true
    }
    
    public override func draw(_ rect: CGRect) {
        button.frame = bounds
    }
    
    public func setShadow(radius: CGFloat, opacity: Float, offset: CGSize = .zero, color: CGColor = UIColor.black.cgColor) {
        super.layer.shadowRadius = radius
        super.layer.shadowOpacity = opacity
        super.layer.shadowOffset = offset
        super.layer.shadowColor = color
    }
    
   public  override func addSubview(_ view: UIView) {
        button.addSubview(view)
    }
    
    //MARK: - Tracking Methods
    
    private var isButtonScaled = false
    
    private var longPressTimer = Timer()
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        longPressTimer = Timer.scheduledTimer(timeInterval: minimumPressDuration, target: self, selector: #selector(handleScale), userInfo: nil, repeats: false)
        return true
    }
    
    @objc private func handleScale() {
        isButtonScaled = true
        longPressTimer.invalidate()
        scaleAnimation()
    }
    
    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if !bounds.contains(touchPoint) && !isButtonScaled {
            handleScale()
        }
        return true
    }
    
    ///The frame for which a user touch within triggers a `touchUpInside` event.
    private var extendedFrame: CGRect {
        let scaleFactor: CGFloat = 1.5
        let maximumDx = min((scaleFactor - 1) * min(bounds.width, bounds.height), 100)
        let dx: CGFloat = -1 * max(50, maximumDx)
        return bounds.insetBy(dx: dx, dy: dx)
    }
    
    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        longPressTimer.invalidate()
        
        guard let touchPoint = touch?.location(in: self) else { return }
        if !extendedFrame.contains(touchPoint) {
            delegate?.didTouchUpOutside(onButton: self)
            cancelSpringAnimation()
        } else {
            delegate?.didTouchUpInside(onButton: self)
            if isButtonScaled {
                springAnimation(delay: 0.05)
            } else {
                let velocity = CGSize(width: -springVelocity * button.frame.width / frame.width, height: -springVelocity * button.frame.height / frame.height)
                springAnimation(velocity: velocity)
            }
        }
        button.layer.shouldRasterize = false
        isButtonScaled = false
    }
    
    //MARK: - Animation Methods
    
    @objc private func springAnimation(delay: TimeInterval = 0, velocity: CGSize = CGSize.zero) {
        button.pop_removeAllAnimations()
        guard let springAnim = POPSpringAnimation(propertyNamed: kPOPViewScaleXY) else { return }
        springAnim.fromValue = NSValue(cgSize: CGSize(width: button.frame.width / frame.width - 0.001, height: button.frame.height / frame.height - 0.001))
        springAnim.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
        springAnim.springBounciness = springBounciness
        springAnim.springSpeed = springSpeed
        springAnim.beginTime = CACurrentMediaTime() + delay
        if velocity != CGSize.zero {
            springAnim.velocity = velocity
        }
        button.pop_add(springAnim, forKey: "springAnimation")
    }
    
    @objc private func scaleAnimation() {
        button.pop_removeAllAnimations()
        guard let scaleAnim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY) else { return }
        scaleAnim.toValue = NSValue(cgSize: CGSize(width: scaleFactor, height: scaleFactor))
        scaleAnim.duration = scaleDuration
        scaleAnim.completionBlock = { (_,_)  in
            self.isButtonScaled = true
        }
        button.pop_add(scaleAnim, forKey: "scaleAnimation")
    }
    
    @objc private func cancelSpringAnimation() {
        guard let scaleAnim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY) else { return }
        scaleAnim.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
        scaleAnim.duration = cancelDuration
        button.pop_add(scaleAnim, forKey: "cancelSpringAnimation")
    }
    
    public func removeAllAnimations() {
        button.layer.pop_removeAllAnimations()
        button.frame = bounds
    }
    
}






