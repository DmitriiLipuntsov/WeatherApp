//
//  DeviceSize.swift
//  TonGenerator
//
//  Created by Dmitry Lipuntsov on 19.03.2023.
//

import Foundation

enum Device: String {
    case iPadPro12_9_6thGenSize = "1024.0 1366.0"
    case iPadPro11_4thGenSize   = "834.0 1194.0"
    case iPad10thGenSize        = "820.0 1180.0"
    case iPadMini6thGenSize     = "744.0 1133.0"
    case iPadAir3rdGenSize      = "834.0 1112.0"
    case iPad9thGenSize         = "810.0 1080.0"
    case iPadMini               = "768.0 1024.0"
    
    case iPhone14ProMax = "430.0 932.0"
    case iPhone14Plus   = "428.0 926.0"
    case iPhone11       = "414.0 896.0"
    case iPhone14Pro    = "393.0 852.0"
    case iPhone12       = "390.0 844.0"
    case iPhone11Pro    = "375.0 812.0"
    case iPhone7Plus    = "414.0 736.0"
    case iPhone7        = "375.0 667.0"
    case iPhoneSE1      = "320.0 568.0"
    
    
    var getSize: CGSize {
        let sizeArrayString = self.rawValue.components(separatedBy: " ")
        let width = Int(Double(sizeArrayString[0]) ?? 0)
        let height = Int(Double(sizeArrayString[1]) ?? 0)
        return CGSize(width: width, height: height)
    }
    
    var getHeight: CGFloat {
        return getSize.height
    }
    
    static var currentDevice: Device? {
        let screenSizeString: String = "\(CGFloat.screenWidth) \(CGFloat.screenHeight)"
        return Device(rawValue: screenSizeString)
    }
}

//MARK: - tallerThan
extension Device {
    //MARK: iPads
    static var tallerThanIPadAir3rdGenSize: Bool {
        return .screenHeight > Device.iPadAir3rdGenSize.getHeight
    }
    
    static var tallerThanIPad9thGenSize: Bool {
        return .screenHeight > Device.iPad9thGenSize.getHeight
    }
    
    //MARK: iPhones
    static var tallerThan14Pro: Bool {
        return .screenHeight > Device.iPhone14Pro.getHeight
    }
    
    static var tallerThan11Pro: Bool {
        return .screenHeight > Device.iPhone11Pro.getHeight
    }
    
    static var tallerThan7Plus: Bool {
        return .screenHeight > Device.iPhone7Plus.getHeight
    }
    
    static var tallerThan7: Bool {
        return .screenHeight > Device.iPhone7.getHeight
    }
}

//MARK: - is
extension Device {
    static var isIPad: Bool {
        return .screenHeight >= Device.iPadMini.getHeight
    }
    
    //MARK: IPad
    static var isIPadPro12_9_6thGenSize: Bool {
        return .screenHeight == Device.iPadPro12_9_6thGenSize.getHeight
    }
    
    static var isIPadPro11_4thGenSize: Bool {
        return .screenHeight == Device.iPadPro11_4thGenSize.getHeight
    }
    
    //MARK: IPhone
    static var isIPhone14ProMax: Bool {
        return .screenHeight == Device.iPhone14ProMax.getHeight
    }
    
    static var isIPhone7: Bool {
        return .screenHeight == Device.iPhone7.getHeight
    }
    
    static var isSE1: Bool {
        return .screenHeight == Device.iPhoneSE1.getHeight
    }
}
