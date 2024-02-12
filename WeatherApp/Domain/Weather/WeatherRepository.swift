//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation
import Combine
import CoreLocation

class WeatherRepository {
    
    @Published var weatherModel: WeatherModel?
    @Published var forecastModel: [ForecastModel] = []
    @Published var locationAuthorizationStatus: CLAuthorizationStatus?
    
    @Published private var userLocation: CLLocation?
    
    private let openweathermapApiManager = OpenweathermapApiManager()
    private let locationManager = LocationManager()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        subscribe()
        fetchWeather()
        fetchForecast()
    }
    
    func fetchWeather() {
        guard let location = userLocation else { return }
        openweathermapApiManager.fetchWeather(location: location).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                let message = error.localizedDescription
                let destination = "Destination: \n File: \(#file) - Func: \(#function) - Line: \(#line)\n"
                LoggerManager.shared.log(
                    subsystem: .data,
                    level: .error,
                    destination: destination,
                    message: message
                )
            }
        } receiveValue: { [weak self] weather in
            self?.weatherModel = self?.transformWeatherToWeatherModel(weather)
        }
        .store(in: &cancellables)
    }
    
    func fetchForecast() {
        guard let location = userLocation else { return }
        openweathermapApiManager.fetchForecast(location: location).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                let message = error.localizedDescription
                let destination = "Destination: \n File: \(#file) - Func: \(#function) - Line: \(#line)\n"
                LoggerManager.shared.log(
                    subsystem: .data,
                    level: .error,
                    destination: destination,
                    message: message
                )
            }
        } receiveValue: { [weak self] forecast in
            guard let self = self else { return }
            self.forecastModel = self.transformForecastToForecastModel(forecast)
        }
        .store(in: &cancellables)
    }
    
    func requestAuthorization() {
        locationManager.requestAuthorization()
    }
}

//MARK: - Transform Model
private extension WeatherRepository {
    private func transformWeatherToWeatherModel(_ weather: CurrentWeather) -> WeatherModel {
        let icon = OpenweathermapApiEndpoint.reciveImageUrl(code: weather.weather.first?.icon ?? "").absoluteString
        let temperature = Int(weather.main.temp)
        var comment = ""
        
        switch temperature {
        case ..<0:
            comment = "Very cold. Wear warm clothes!"
        case 0..<15:
            comment = "Cool. Don't forget to take a sweater or light jacket."
        default:
            comment = "Warm. Enjoy the beautiful weather!"
        }
        
        return WeatherModel(
            cityName: weather.name,
            temperature: Int(weather.main.temp),
            comment: comment,
            icon: icon
        )
    }
    
    private func transformForecastToForecastModel(_ forecast: Forecast) -> [ForecastModel] {
        let name = forecast.city?.name ?? ""
        return forecast.list.map { forecast in
            let icon = OpenweathermapApiEndpoint.reciveImageUrl(code: forecast.weather?.first?.icon ?? "").absoluteString
            return ForecastModel(
                id: UUID(),
                icon: icon,
                temp: Int(forecast.main?.temp ?? 0),
                cityName: name,
                dt: forecast.dt ?? ""
            )
        }
    }
}

//MARK: - Subscribtions
private extension WeatherRepository {
    private func subscribe() {
        currentLocationSubscribtion()
        locationAuthorizationStatusSubscribe()
    }
    
    private func currentLocationSubscribtion() {
        locationManager.$userLocation.first(where: {$0 != nil}).sink { [weak self] location in
            guard
                let self = self,
                let location = location
            else { return }
            self.userLocation = location
            if self.locationAuthorizationStatus == .authorizedAlways || self.locationAuthorizationStatus == .authorizedWhenInUse {
                self.fetchWeather()
                self.fetchForecast()
            }
        }
        .store(in: &cancellables)
    }
    
    private func locationAuthorizationStatusSubscribe() {
        locationManager.$authorizationStatus
            .sink { [weak self] status in
                self?.locationAuthorizationStatus = status
                if status == .authorizedAlways || status == .authorizedWhenInUse {
                    self?.fetchWeather()
                    self?.fetchForecast()
                }
            }
            .store(in: &cancellables)
    }
    
}
