//
//  ForecastBodyView.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 13.02.2024.
//

import SwiftUI

struct   ForecastBodyView : View {
    
    @Binding var model: [ForecastModel]
    @Binding var selectedModel: ForecastModel?
    
    var body: some View {
        VStack( spacing: 20){
            Image("MulticolorStripe")
                .resizable()
                .frame(height: 50)
            if !model.isEmpty {
                List(model, id: \.id) { item in
                    let isSelected = item.id == selectedModel?.id
                    CellForecastView(
                        model: item,
                        isDrawBordersOfCell: isSelected
                    )
                }
            } else {
                Text("Empty")
            }
        }
        
    }
}
