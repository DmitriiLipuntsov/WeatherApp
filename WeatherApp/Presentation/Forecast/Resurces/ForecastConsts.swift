//
//  ForecastConsts.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 13.02.2024.
//

import Foundation

struct ForecastConsts {
    //MARK: Cell
    static var tempPadding: CGFloat {
        return Device.tallerThan7 ? 30 : 10
    }
    
    static var iconSize: CGFloat {
        return Device.tallerThan7 ? 100 : 50
    }
    
    static var cityFontSize: CGFloat {
        return Device.tallerThan7 ? 20 : 15
    }
    
    static var tempFontSize: CGFloat {
        return Device.tallerThan7 ? 18 : 12
    }
}
