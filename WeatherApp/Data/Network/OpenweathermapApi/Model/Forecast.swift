//
//  Forecast.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation

struct Forecast: Decodable {
    let list: [Weather]
    let city: City?
}

extension Forecast {
    struct Weather: Decodable {
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
    struct Parameters: Decodable {
        let temp: Double?
    }
}

extension Forecast {
    struct Icon: Decodable {
        let main: String?
        let description: String?
        let icon: String?
    }
}

extension Forecast {
    struct City: Decodable {
        let name: String?
    }
}
