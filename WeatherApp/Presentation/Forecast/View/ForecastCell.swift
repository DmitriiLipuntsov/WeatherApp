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
                .frame(
                    width: ForecastConsts.iconSize,
                    height: ForecastConsts.iconSize
                )
                
                VStack {
                    Text(model.cityName)
                        .font(.custom("Arial", size: HomeConsts.cityFontSize))
                    Text(model.dt)
                        .font(.custom("Arial", size: HomeConsts.tempFontSize))
                }
                
                Spacer()
                
                Text(String(model.temp))
                    .padding(ForecastConsts.tempPadding)
                    .foregroundColor(Color.blue)
            }
        }
        .contentShape(Rectangle())
    }
    
}
