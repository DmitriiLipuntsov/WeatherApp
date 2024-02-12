//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func requestAuthorization() {
        manager.requestAlwaysAuthorization()
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        switch status {
        case .notDetermined:
            debugPrint("Debug: Not determined")
        case .restricted:
            debugPrint("Debug: Restricted")
        case .denied:
            debugPrint("Debug: Denied")
        case .authorizedAlways:
            debugPrint("Debug:Auth always")
        case .authorizedWhenInUse:
            debugPrint("Debug: Auth when in use")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location
        manager.stopUpdatingLocation()
    }
}
