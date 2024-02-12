//
//  OpenweathermapApiEndpoint.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation

struct OpenweathermapApiEndpoint {
    static let token: String = "f0fb4eac38f87c1d5d02858dc7fbcad0"
    
    var path: Path
    
    static func reciveImageUrl(code: String) -> URL {
        let urlString = "http://openweathermap.org/img/wn/\(code)@2x.png"
        guard let url = URL(string: urlString) else {
            preconditionFailure("Invalid URL components: \(urlString)")
        }
        return url
    }
}


//MARK: - queryItems
extension OpenweathermapApiEndpoint {
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "appid", value: OpenweathermapApiEndpoint.token)]
    }
}

extension OpenweathermapApiEndpoint {
    var url: URL? {
        let host = "https://"
        let domain = "api.openweathermap.org"
        let path = path.rawValue
//        guard let url = components.url else {
//            preconditionFailure("Invalid URL components: \(components)")
//        }
        let urlString = host + domain + path
        return URL(string: urlString)
    }
}

extension OpenweathermapApiEndpoint {
    enum Path {
        case currentWeather(lat: Double, lon: Double)
        case forecastWeather(lat: Double, lon: Double)
        
        var rawValue: String {
            switch self {
            case .currentWeather(let lat, let lon):
                return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric" + key
            case .forecastWeather(let lat, let lon):
                return "/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric" + key
            }
        }
        
        var key: String {
            return "&appid=f0fb4eac38f87c1d5d02858dc7fbcad0"
        }
    }
}
