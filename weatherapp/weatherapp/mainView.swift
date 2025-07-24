//
//  SwiftUIView.swift
//  weatherapp
//
//  Created by Pavneet Cheema on 11/25/24.
//

import SwiftUI

struct mainView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5) // Move text
        UITabBar.appearance().itemSpacing = 20
        // Adjusts system image position
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)], for:.normal
            
          )
    }
    var body: some View {

        TabView {
            PiWeatherView(viewTitle: "Temprature", viewIcon: "thermometer.sun")
                .tabItem {
                    VStack{
                        Image(systemName: "thermometer.sun")
                        Text("temprature")
                    }
                }
            PiWeatherView(viewTitle: "Humidity", viewIcon: "drop")
                .tabItem {
                    Image(systemName: "drop.fill")
                    Text("humidity")
                }
            PiWeatherView(viewTitle: "Pressure", viewIcon: "tirepressure")
                .tabItem {
                    Image(systemName: "tirepressure")
                    Text("Pressure")
                }

            
        }
    }
}

#Preview {
    mainView()
}
