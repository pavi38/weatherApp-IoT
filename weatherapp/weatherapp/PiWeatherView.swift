//
//  PiWeatherView.swift
//  weatherapp
//
//  Created by Pavneet Cheema on 11/25/24.
//

import SwiftUI

struct PiWeatherView: View {
    @State var viewTitle: String = "Temprature"
    @State var viewIcon: String = "thermometer.sun"
    @StateObject var vm: weatherViewModel = weatherViewModel()
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            VStack{
                Text(viewTitle)
                    .padding(.bottom, 40)
                    .font(.system(size: 42, weight: .medium, design: .default))
                    .foregroundColor(.white)
                VStack{
                    Image(systemName: viewIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 150)
                    Text(String(vm.temprature))
                        .padding(.top, 60)
                        .font(.system(size: 80, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    PiWeatherView()
}
