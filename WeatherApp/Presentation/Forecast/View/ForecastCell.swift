//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 13.02.2024.
//

import SwiftUI

struct CellForecastView: View {
    var model: ForecastModel
    
    var body: some View {
        ZStack{
            HStack {
                NetworkImageView(imageUrlString: model.icon) {
                    Image(systemName: "photo")
                } progressBlock: {
                    ProgressView()
                }
                .frame(width: 100 , height: 100)
                
                VStack {
                    Text(model.cityName)
                    Text(model.dt)
                }
                
                Spacer()
                
                Text(String(model.temp))
                    .padding(40)
                    .scaleEffect(2.5)
                    .foregroundColor(Color.blue)
            }
        }
        .padding(.horizontal , -15)
        .contentShape(Rectangle())
    }
    
}
