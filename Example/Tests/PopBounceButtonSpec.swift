//
//  PopBounceButton_Spec.swift
//  PopBounceButton_Tests
//
//  Created by Mac Gallagher on 12/30/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble

@testable import PopBounceButton

class PopBounceButtionSpec: QuickSpec {
    private let buttonHeight: CGFloat = 50
    private let buttonWidth: CGFloat = 100
    
    override func spec() {
        describe("initialization") {
            var button: PopBounceButton!
            
            beforeEach {
                button = self.setupButton()
            }
            
            context("when initializing a button") {
                it("should have a spring bounciness of 19") {
                    expect(button.springBounciness).to(equal(19))
                }
                
                it("should have a spring speed of 10") {
                    expect(button.springSpeed).to(equal(10))
                }
                
                it("should have a spring velocity of 6") {
                    expect(button.springVelocity).to(equal(6))
                }
                
                it("should have a cancel tap scale duration of 0.3") {
                    expect(button.cancelTapScaleDuration).to(equal(0.3))
                }
                
                it("should have a long press scale factor of 0.7") {
                    expect(button.longPressScaleFactor).to(equal(0.7))
                }
                
                it("should have a long press scale duration of 0.1") {
                    expect(button.longPressScaleDuration).to(equal(0.1))
                }
                
                it("should have a minimum press duration of 0.2") {
                    expect(button.minimumPressDuration).to(equal(0.2))
                }
                
                it("should have a rasterized layer with the correct rasterization scale") {
                    expect(button.layer.rasterizationScale).to(equal(UIScreen.main.scale))
                    expect(button.layer.shouldRasterize).to(beTrue())
                }
                
                it("should have the correct initial bounds") {
                    expect(button.bounds.width).to(equal(self.buttonWidth))
                    expect(button.bounds.height).to(equal(self.buttonHeight))
                }
                
                it("should not be scaled") {
                    expect(button.isScaled).to(beFalse())
                }
                
                it("should not have a valid long press timer") {
                    expect(button.longPressTimer.isValid).to(beFalse())
                }
            }
        }
        
        describe("touch events") {
            describe("when a touchDown event is recognized") {
                var button: PopBounceButton!
                
                beforeEach {
                    button = self.setupButton()
                    button.sendActions(for: .touchDown)
                }
                
                it("should activate the long press timer") {
                    expect(button.longPressTimer.isValid).to(beTrue())
                }
            }
            
            describe("when a touchUpInside event is recognized after a touchDown event") {
                var button: PopBounceButton!
                
                beforeEach {
                    button = self.setupButton()
                    button.sendActions(for: .touchDown)
                    button.sendActions(for: .touchUpInside)
                }
                
                it("should invalidate the long press timer") {
                    expect(button.longPressTimer.isValid).to(beFalse())
                }
            }
            
            describe("when a touchUpOutside event is recognized after a touchDown event") {
                var button: PopBounceButton!
                
                beforeEach {
                    button = self.setupButton()
                    button.sendActions(for: .touchDown)
                    button.sendActions(for: .touchUpOutside)
                }
                
                it("should invalidate the long press timer") {
                    expect(button.longPressTimer.isValid).to(beFalse())
                }
            }
            
            describe("when long pressing shorter than the minimum press duration") {
                let minimumPressDuration: TimeInterval = 0.2
                var button: PopBounceButton!
                
                beforeEach {
                    button = self.setupButton(configure: { button in
                        button.minimumPressDuration = minimumPressDuration
                    })
                    button.sendActions(for: .touchDown)
                }
                
                it("should not invalidate the long press timer") {
                    expect(button.longPressTimer.isValid).toEventually(beTrue(), timeout: minimumPressDuration - 0.1)
                }
                
                it("should not scale the button") {
                    expect(button.isScaled).toEventually(beFalse(), timeout: minimumPressDuration - 0.1)
                }
            }
            
            describe("when long pressing longer or equal to the minimum press duration") {
                let minimumPressDuration: TimeInterval = 0.2
                var button: PopBounceButton!
                
                beforeEach {
                    button = self.setupButton(configure: { button in
                        button.minimumPressDuration = minimumPressDuration
                    })
                    button.sendActions(for: .touchDown)
                }
                
                it("should invalidate the long press timer") {
                    expect(button.longPressTimer.isValid).toEventually(beTrue(), timeout: minimumPressDuration + 0.1)
                }
                
                it("should scale the button") {
                    expect(button.isScaled).toEventually(beFalse(), timeout: minimumPressDuration + 0.1)
                }
            }
        }
        
        describe("animations") {
            describe("when a touchUpInside event is recognized on a button that is not scaled") {
                let springBounciness: CGFloat = 19
                let springSpeed: CGFloat = 10
                let springVelocity: CGFloat = 6
                var button: PopBounceButton!
                var mockButtonAnimator: MockButtonAnimator!
                
                beforeEach {
                    mockButtonAnimator = MockButtonAnimator()
                    button = self.setupButton(configure: { button in
                        button.animator = mockButtonAnimator
                        button.springBounciness = springBounciness
                        button.springSpeed = springSpeed
                        button.springVelocity = springVelocity
                    })
                    button.sendActions(for: .touchUpInside)
                }
                
                it("should animate a bounce effect with the correct parameters") {
                    expect(mockButtonAnimator.didApplySpringScaleAnimation).to(beTrue())
                    expect(mockButtonAnimator.springDelay).to(equal(0))
                    expect(mockButtonAnimator.springSpeed).to(equal(springSpeed))
                    expect(mockButtonAnimator.springBounciness).to(equal(springBounciness))
                    expect(mockButtonAnimator.springScaleToValue).to(equal(CGPoint.one))
                    expect(mockButtonAnimator.springInitialVelocity).to(equal(CGPoint(c: -springVelocity)))
                }
            }
            
            describe("when a touchUpInside event is recognized on a button that is scaled") {
                let springBounciness: CGFloat = 19
                let springSpeed: CGFloat = 10
                let springVelocity: CGFloat = 6
                let touchUpInsideScaledDelay = 0.1
                var button: PopBounceButton!
                var mockButtonAnimator: MockButtonAnimator!
                
                beforeEach {
                    mockButtonAnimator = MockButtonAnimator()
                    button = self.setupButton(configure: { button in
                        button.animator = mockButtonAnimator
                        button.springBounciness = springBounciness
                        button.springSpeed = springSpeed
                        button.springVelocity = springVelocity
                        button.touchUpInsideScaledDelay = touchUpInsideScaledDelay
                        button.isScaled = true
                    })
                    button.sendActions(for: .touchUpInside)
                }
                
                it("should animate a bounce effect with the correct parameters") {
                    expect(mockButtonAnimator.didApplySpringScaleAnimation).to(beTrue())
                    expect(mockButtonAnimator.springDelay).to(equal(touchUpInsideScaledDelay))
                    expect(mockButtonAnimator.springSpeed).to(equal(springSpeed))
                    expect(mockButtonAnimator.springBounciness).to(equal(springBounciness))
                    expect(mockButtonAnimator.springScaleToValue).to(equal(CGPoint.one))
                    expect(mockButtonAnimator.springInitialVelocity).to(equal(.zero))
                }
            }
            
            describe("when a touchUpOutside event is recognized") {
                let scaleDuration: TimeInterval = 0.5
                var button: PopBounceButton!
                var mockButtonAnimator: MockButtonAnimator!
                
                beforeEach {
                    mockButtonAnimator = MockButtonAnimator()
                    button = self.setupButton(configure: { button in
                        button.animator = mockButtonAnimator
                        button.cancelTapScaleDuration = scaleDuration
                    })
                    button.sendActions(for: .touchUpOutside)
                }
                
                it("should animate a scale effect with the correct parameters") {
                    expect(mockButtonAnimator.didApplyScaleAnimation).to(beTrue())
                    expect(mockButtonAnimator.scaleDelay).to(equal(0))
                    expect(mockButtonAnimator.scaleToValue).to(equal(CGPoint.one))
                    expect(mockButtonAnimator.scaleDuration).to(equal(scaleDuration))
                }
            }
            
            describe("when a long press is recognized") {
                let minimumPressDuration: TimeInterval = 0.2
                let longPressScaleDuration: TimeInterval = 0.8
                let longPressScaleFactor: CGFloat = 0.6
                var mockButtonAnimator: MockButtonAnimator!
                var button: PopBounceButton!
                
                beforeEach {
                    mockButtonAnimator = MockButtonAnimator()
                    button = self.setupButton(configure: { button in
                        button.animator = mockButtonAnimator
                        button.minimumPressDuration = minimumPressDuration
                        button.longPressScaleFactor = longPressScaleFactor
                        button.longPressScaleDuration = longPressScaleDuration
                    })
                    button.sendActions(for: .touchDown)
                }
                
                it("should animate a scale effect with the correct parameters") {
                    expect(mockButtonAnimator.didApplyScaleAnimation).toEventually(beTrue())
                    expect(mockButtonAnimator.scaleDuration).toEventually(equal(longPressScaleDuration))
                    expect(mockButtonAnimator.scaleDelay).toEventually(equal(0))
                    expect(mockButtonAnimator.scaleToValue).toEventually(equal(CGPoint(c: longPressScaleFactor)))
                }
            }
            
            describe("when a touchDown is recognized but a long press is not recognized") {
                let minimumPressDuration: TimeInterval = 0.2
                var mockButtonAnimator: MockButtonAnimator!
                var button: PopBounceButton!
                
                beforeEach {
                    mockButtonAnimator = MockButtonAnimator()
                    button = self.setupButton(configure: { button in
                        button.animator = mockButtonAnimator
                        button.minimumPressDuration = minimumPressDuration
                    })
                    button.sendActions(for: .touchDown)
                }
                
                it("should not animate") {
                    expect(mockButtonAnimator.didApplyScaleAnimation).to(beFalse())
                    expect(mockButtonAnimator.didApplySpringScaleAnimation).to(beFalse())
                }
            }
        }
    }
}

extension PopBounceButtionSpec {
    func setupButton(configure: (PopBounceButton) -> Void = { _ in }) -> PopBounceButton {
        let parentView = UIView()
        let button = PopBounceButton()
        parentView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        configure(button)
        
        button.setNeedsLayout()
        button.layoutIfNeeded()
        button.draw(button.frame)
        
        return button
    }
}
