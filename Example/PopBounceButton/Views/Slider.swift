//
//  Slider.swift
//  PopBounceButton_Example
//
//  Created by Mac Gallagher on 12/1/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

class Slider: UISlider {
    required init(minimumValue: Float, maximumValue: Float) {
        super.init(frame: .zero)
        initialize(minimumValue: minimumValue, maximumValue: maximumValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(minimumValue: Float = 0, maximumValue: Float = 1) {
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        tintColor = UIColor.green
    }
}
