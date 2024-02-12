//
//  AppViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation

class AppViewModel: ObservableObject {
    
    let persistenceController = PersistenceController.shared
    private let locationManager = LocationManager()
    
    init() {
        
    }
}
