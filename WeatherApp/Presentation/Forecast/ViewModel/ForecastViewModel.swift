//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 13.02.2024.
//

import Foundation
import Combine

final class ForecastViewModel: ObservableObject {
    @Published var forecast: [ForecastModel] = []
    @Published var selectedCell: ForecastModel?
    @Published var locationAccessDenied = false
    
    let repository = WeatherRepository()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        subscribe()
    }
}

//MARK: - Subscribtions
extension ForecastViewModel {
    private func subscribe() {
        forecastSubscribe()
        locationAuthorizationStatusSubscribe()
    }
    
    private func forecastSubscribe() {
        repository.$forecastModel.sink { [weak self] forecast in
            guard
                let self = self
            else { return }
            DispatchQueue.main.async {
                if !forecast.isEmpty {
                    self.forecast = forecast
                }
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
