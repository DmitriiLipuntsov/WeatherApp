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
        var dt: String?
        let main: Parameters?
        let weather: [Icon]?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            dt = try container.decode(String.self, forKey: .dt)
            main = try container.decode(Parameters.self, forKey: .main)
            weather = try container.decode([Icon].self, forKey: .weather)
            
            if let originalDateString = dt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let date = dateFormatter.date(from: originalDateString) {
                    dateFormatter.dateFormat = "MM.dd  HH:mm"
                    dt = dateFormatter.string(from: date)
                }
            }
        }
        
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
