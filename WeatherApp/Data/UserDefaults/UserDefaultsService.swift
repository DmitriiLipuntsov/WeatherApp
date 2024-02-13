//
//  UserDefaultsService.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 13.02.2024.
//

import Foundation

enum UserDefaultsKeys: String {
    case currentWeather
    case forecast
}


class UserDefaultsService {
    static var currentWeather: Data? {
        get {
            return UserDefaults.standard.data(forKey: getKey(.currentWeather))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: getKey(.currentWeather))
        }
    }
    
    static var forecast: Data? {
        get {
            return UserDefaults.standard.data(forKey: getKey(.forecast))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: getKey(.forecast))
        }
    }
}


private extension UserDefaultsService {
    private static func getKey(_ type: UserDefaultsKeys) -> String {
        return type.rawValue
    }
}
