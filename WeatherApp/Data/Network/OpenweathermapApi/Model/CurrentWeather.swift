//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation

struct CurrentWeather: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

extension CurrentWeather {
    struct Weather: Decodable {
        let icon: String
    }
}

extension CurrentWeather {
    struct Main: Decodable {
        let temp: Double
    }
}
