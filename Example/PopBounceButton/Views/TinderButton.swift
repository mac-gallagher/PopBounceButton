//
//  TinderButton.swift
//  PopBounceButton_Example
//
//  Created by Mac Gallagher on 12/1/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import PopBounceButton

class TinderButton: PopBounceButton {
    override init() {
        super.init()
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = .white
        layer.masksToBounds = true
        adjustsImageWhenHighlighted = false
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = bounds.width / 2
    }
}
