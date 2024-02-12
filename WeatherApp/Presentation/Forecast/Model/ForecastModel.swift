//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 13.02.2024.
//

import Foundation

struct ForecastModel: Identifiable {
    let id: UUID
    let icon: String
    let temp: Int
    let cityName: String
    let dt: String
}
