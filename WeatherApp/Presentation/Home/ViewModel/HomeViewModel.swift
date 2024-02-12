//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation
import Combine

class HomeViewModel: NSObject, ObservableObject {
    
    @Published var currentWeather: WeatherModel?
    @Published var locationAccessDenied = false
    
    private let repository = WeatherRepository()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override init() {
        super.init()
        subscribe()
    }
    
    func requestAuthorization() {
        repository.requestAuthorization()
    }
}

//MARK: - Subscribtions
extension HomeViewModel {
    private func subscribe() {
        currentWeatherSubscribe()
        locationAuthorizationStatusSubscribe()
    }
    
    private func currentWeatherSubscribe() {
        repository.$weatherModel.sink { [weak self] weather in
            guard
                let self = self
            else { return }
            DispatchQueue.main.async {
                self.currentWeather = weather
            }
        }
        .store(in: &cancellables)
    }
    
    private func locationAuthorizationStatusSubscribe() {
        repository.$locationAuthorizationStatus
            .sink { [weak self] status in
                if let status = status {
                    DispatchQueue.main.async {
                        self?.locationAccessDenied = (status == .denied || status == .restricted)
                    }
                }
            }
            .store(in: &cancellables)
    }

}
