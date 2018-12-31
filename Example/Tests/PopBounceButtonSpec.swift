//
//  PopBounceButton_Spec.swift
//  PopBounceButton_Tests
//
//  Created by Mac Gallagher on 12/30/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Quick
import Nimble
import PopBounceButton

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
                
                it("should not be scaled") {
                    expect(button.bounds.width).to(equal(self.buttonWidth))
                    expect(button.bounds.height).to(equal(self.buttonHeight))
                }
            }
        }
        
        //add willScale function to test proper scaling
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
        
        button.layoutIfNeeded()
        return button
    }
}
