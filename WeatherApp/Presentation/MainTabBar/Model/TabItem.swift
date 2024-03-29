//
//  TabItem.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import Foundation

enum TabItem: CaseIterable {
    case forecast
    case home
    case empty
    
    var name: String {
        switch self {
        case .forecast:
            return "Forecast"
        case .home:
            return ""
        case .empty:
            return ""
        }
    }
    
    var imageName: String {
        if #available(iOS 16.0, *) {
              switch self {
              case .forecast:
                  return "list.clipboard"
              case .home:
                  return "house"
              case .empty:
                  return "questionmark.circle"
              }
          } else {
              switch self {
              case .forecast:
                  return "square.and.pencil"
              case .home:
                  return "house"
              case .empty:
                  return "questionmark.circle"
              }
          }
    }
}
