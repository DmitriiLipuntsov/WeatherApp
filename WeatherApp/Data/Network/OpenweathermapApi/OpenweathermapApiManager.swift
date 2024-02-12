//
//  OpenweathermapApiManager.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation
import Combine
import CoreLocation

enum NetworkError: Error {
    case invalidUrl
    case invalidData
    case decoding
    case noSelf
}

class OpenweathermapApiManager {
    
    private let networkManager = NetworkManager()
    private let decoder = JSONDecoder()
    
    func fetchWeather(location: CLLocation) -> AnyPublisher<CurrentWeather, Error> {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let path = OpenweathermapApiEndpoint.Path.currentWeather(lat: lat, lon: lon)
        guard
            let url = OpenweathermapApiEndpoint(path: path).url
        else {
            let error = NetworkError.invalidUrl
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return networkManager.request(
            type: CurrentWeather.self,
            url: url,
            method: .get,
            headers: [:],
            body: nil)
    }
    
    func fetchForecast(location: CLLocation) -> AnyPublisher<Forecast, Error> {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let path = OpenweathermapApiEndpoint.Path.forecastWeather(lat: lat, lon: lon)
        guard
            let url = OpenweathermapApiEndpoint(path: path).url
        else {
            let error = NetworkError.invalidUrl
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return networkManager.request(
            type: Forecast.self,
            url: url,
            method: .get,
            headers: [:],
            body: nil)
    }
}
