//
//  ResizingLabel.swift
//  PopBounceButton_Example
//
//  Created by Mac Gallagher on 12/1/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit

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
