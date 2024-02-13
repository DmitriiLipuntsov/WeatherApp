//
//  ForecastBodyView.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 13.02.2024.
//

import SwiftUI

struct ForecastBodyView : View {
    
    @Binding var model: [ForecastModel]
    
    var body: some View {
        VStack(spacing: 20){
            if !model.isEmpty {
                List(model, id: \.id) { item in
                    CellForecastView(model: item)
                }
            } else {
                Text("Empty")
            }
        }
        
    }
}
