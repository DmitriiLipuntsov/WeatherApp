//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation

struct CurrentWeather: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

extension CurrentWeather {
    struct Weather: Codable {
        let icon: String
    }
}

extension CurrentWeather {
    struct Main: Codable {
        let temp: Double
    }
}
