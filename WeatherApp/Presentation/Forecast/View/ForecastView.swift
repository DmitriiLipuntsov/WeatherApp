//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import SwiftUI

struct ForecastView: View {
    @StateObject var viewModel = ForecastViewModel()
    
    var body: some View {
        ZStack {
            if !viewModel.forecast.isEmpty {
                ForecastBodyView(model: $viewModel.forecast)
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
    ForecastView()
}
