//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import CoreLocation
import UIKit

class LocationManager: NSObject, ObservableObject {
    let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        requestNotificationsPermisson()
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        switch status {
        case .notDetermined:
            requestAuthorization()
            debugPrint("Debug: Not determined")
        case .restricted:
            requestAuthorization()
            debugPrint("Debug: Restricted")
        case .denied:
            requestAuthorization()
            debugPrint("Debug: Denied")
        case .authorizedAlways:
            manager.startUpdatingLocation()
            debugPrint("Debug:Auth always")
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
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
    
    private func requestNotificationsPermisson() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            
        }
    }
}
