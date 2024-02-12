//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
