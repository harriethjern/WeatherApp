//
//  ForcastView.swift
//  WeatherApp
//
//  Created by Harriet Hjern on 2025-02-05.

//  For the second screen (7-day forecast).

import Foundation
import SwiftUI

struct ForcastView: View {
    @State private var model = WeatherViewModel()
    @State private var currentlocation: String?
    @State private var currentWeather: Weather?
    @State private var location: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Next seven days:")
                    .font(.largeTitle)
                    .padding()
                
// row 25-40 ChatGPT: https://chatgpt.com/c/67a39637-ec68-800b-ac5e-3c4e7c7c6b15
                if let times = currentWeather?.time,
                   let maxTemperatures = currentWeather?.temperature2MMax,
                   let minTemperatures = currentWeather?.temperature2MMin,
                   let weatherCodes = currentWeather?.weatherCode{
                    
                    List {
                        ForEach(Array(times.enumerated()), id: \.0) { index, time in
                            VStack(alignment: .leading) {
                                Text("\(time)")
                                    .font(.headline)
                                Text("Weather: \(WeatherViewModel().translateWeatherCode(for : weatherCodes[index]))")
                                Text("Max: \(maxTemperatures[index], specifier: "%.1f")°C")
                                Text("Min: \(minTemperatures[index], specifier: "%.1f")°C")
                            }
                            .padding()
                        }
                    }
                }
            }
            .task {
                if let weather = await model.loadWeather(){
                    currentWeather = weather
                }
            }
        }
    }
}

    
#Preview {
    ForcastView()
}
