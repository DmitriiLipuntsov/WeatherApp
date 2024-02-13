//
//  HomeView.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            if let weather = viewModel.currentWeather {
                VStack(spacing: 20) {
                    TextField("Enter city name", text: $viewModel.cityNameInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 80)
                    
                    Button("Change City") {
                        viewModel.fetchWeather()
                    }
                    .padding(.horizontal)
                    
                    Text("City: \(weather.cityName)")
                        .foregroundStyle(.indigo)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                    
                    Text("Temperature: \(weather.temperature)°C")
                        .fontWeight(.semibold)
                    
                    Text("Comment: \(weather.comment)")
                        .padding(.horizontal, 50)
                    
                    NetworkImageView(imageUrlString: weather.icon) {
                        Image(systemName: "photo")
                            
                    } progressBlock: {
                       ProgressView()
                        
                    }
                    .frame(width: 100 , height: 100)
                    
                }
            } else if viewModel.locationAccessDenied {
                Text("Access to location is denied. Please go to settings to enable it.")
                    .frame(width: .screenWidth / 2)
                Button("Open Settings") {
                    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(settingsURL) {
                        UIApplication.shared.open(settingsURL)
                    }
                }
                .padding(.top, 20)
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    HomeView()
}
