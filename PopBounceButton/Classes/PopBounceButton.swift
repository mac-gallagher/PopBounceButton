//
//  PopBounceButton.swift
//  PopBounceButton
//
//  Created by Mac Gallagher on 5/25/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import pop

open class PopBounceButton: UIControl {
    
    //MARK: - Variables
    
    //MARK: Spring Animation Settings
    
    open var springBounciness: CGFloat = 19
    
    open var springSpeed: CGFloat = 10
    
    open var springVelocity: CGFloat = 6
    
    open var cancelDuration: TimeInterval = 0.3
    
    //MARK: Long Press Animation Settings
    
    open var scaleFactor: CGFloat = 0.7
    
    open var scaleDuration: TimeInterval = 0.1
    
    open var minimumPressDuration: TimeInterval = 0.2
    
    //MARK: Title Configuration
    
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
    
    //MARK: Presentation Configuration
    
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
    
    open override var backgroundColor: UIColor? {
        didSet {
            button.backgroundColor = backgroundColor
            super.backgroundColor = .clear
        }
    }
    
    //MARK: Edge Insets Configuration
    
    open var contentEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            button.contentEdgeInsets = contentEdgeInsets
        }
    }
    
    open var titleEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            button.titleEdgeInsets = titleEdgeInsets
        }
    }
    
    open var imageEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            button.imageEdgeInsets = imageEdgeInsets
        }
    }
    
    //MARK: Dimensions
    
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
    
    //MARK: Other Variables
    
    private var button = UIButton(type: .custom)
    
    public var imageView: UIImageView? {
        return button.imageView
    }
    
    open override var layer: CALayer {
        return button.layer
    }
    
    // MARK: - Initialization
    
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
        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(handleTouchUpOutside), for: .touchUpOutside)
        
        button.isUserInteractionEnabled = false
        button.layer.masksToBounds = true
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    //MARK: - Customization
    
    open func setShadow(radius: CGFloat, opacity: Float, offset: CGSize = .zero, color: UIColor = UIColor.black) {
        super.layer.shadowRadius = radius
        super.layer.shadowOpacity = opacity
        super.layer.shadowOffset = offset
        super.layer.shadowColor = color.cgColor
    }
    
    //MARK: - Touch Handling
    
    private var isButtonScaled = false
    
    private var longPressTimer = Timer()
    
    @objc private func handleTouchDown() {
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        longPressTimer = Timer.scheduledTimer(timeInterval: minimumPressDuration, target: self, selector: #selector(handleScale), userInfo: nil, repeats: false)
    }
    
    open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if !bounds.contains(touchPoint) && !isButtonScaled {
            handleScale()
        }
        return true
    }
    
    @objc private func handleScale() {
        longPressTimer.invalidate()
        isButtonScaled = true
        scaleAnimation()
    }
    
    @objc private func handleTouchUpInside() {
        if isButtonScaled {
            springAnimation(delay: 0.05)
        } else {
            let velocityFactor = -button.frame.width / frame.width
            let velocity = CGSize(width: velocityFactor * springVelocity, height: velocityFactor * springVelocity)
            springAnimation(velocity: velocity)
        }
        resetButton()
    }
    
    @objc private func handleTouchUpOutside() {
        cancelSpringAnimation()
        resetButton()
    }
    
    private func resetButton() {
        longPressTimer.invalidate()
        button.layer.shouldRasterize = false
        isButtonScaled = false
    }
    
    //MARK: - Animation
    
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
        button.pop_add(scaleAnim, forKey: "scaleAnimation")
    }
    
    @objc private func cancelSpringAnimation() {
        guard let scaleAnim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY) else { return }
        scaleAnim.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
        scaleAnim.duration = cancelDuration
        button.pop_add(scaleAnim, forKey: "cancelSpringAnimation")
    }
    
    open func removeAllAnimations() {
        button.layer.pop_removeAllAnimations()
    }
    
}
