//
//  CGFloat+Ex.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import SwiftUI

extension CGFloat {
    static var screenWidth: CGFloat {
        get {
            UIScreen.main.bounds.width
        }
    }
    
    static var screenHeight: CGFloat {
        get {
            UIScreen.main.bounds.height
        }
    }
    
    static var screenCenter: CGPoint {
        get {
            let x = screenWidth / 2
            let y = screenHeight / 2
            return CGPoint(x: x, y: y)
        }
    }
    
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        return Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
}
