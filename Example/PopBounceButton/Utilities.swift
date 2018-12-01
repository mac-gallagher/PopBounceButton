//
//  Utilities.swift
//  Demo
//
//  Created by Mac Gallagher on 6/27/18.
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

class ResizingLabel: UILabel {
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(fontSize: CGFloat = 17) {
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
    }
}
