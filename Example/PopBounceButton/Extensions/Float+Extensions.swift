//
//  Float+Extensions.swift
//  PopBounceButton_Example
//
//  Created by Mac Gallagher on 11/30/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import Foundation

extension Float {
    func rounded(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
