//
//  TabBarView.swift
//  WeatherApp
//
//  Created by Dmitry Lipuntsov on 12.02.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab: TabItem = .home
    @State var exSelectedTab: TabItem = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabItem.allCases, id: \.self) { tabItem in
                switch tabItem {
                case .forecast:
                    ForecastView()
                        .tabItem {
                            Image(systemName: tabItem.imageName)
                            Text(tabItem.name)
                        }
                case .home:
                    HomeView()
                        .tabItem {
                            EmptyView()
                        }
                case .empty:
                    Text("")
                        .tabItem {
//                            Image(systemName: tabItem.imageName)
//                            Text(tabItem.name)
                        }
                }
            }
        }
        .overlay(
            Button(action: {
                selectedTab = .home
            }, label: {
                Image(systemName: TabItem.home.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            })
            .frame(width: 80, height: 80)
            .background(Color.blue)
            .clipShape(Circle())
            .shadow(radius: 5, y: 10)
            .padding(.bottom, -5)
            
            , alignment: .bottom
        )
        .onChange(of: selectedTab) { newValue in
            if newValue == .empty {
                selectedTab = exSelectedTab
            } else {
                exSelectedTab = selectedTab
            }
        }
    }
}

#Preview {
    TabBarView()
}
