//
//  Forecast.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation

struct Forecast: Codable {
    let list: [Weather]
    let city: City?
}

extension Forecast {
    struct Weather: Codable {
        let dt: String?
        let main: Parameters?
        let weather: [Icon]?
        
        enum CodingKeys : String, CodingKey {
            case dt = "dt_txt"
            case main
            case weather
        }
    }
}

extension Forecast {
    struct Parameters: Codable {
        let temp: Double?
    }
}

extension Forecast {
    struct Icon: Codable {
        let main: String?
        let description: String?
        let icon: String?
    }
}

extension Forecast {
    struct City: Codable {
        let name: String?
    }
}
