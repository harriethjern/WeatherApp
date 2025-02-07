//
//  ContentView.swift
//  WeatherApp
//
//  Created by Harriet Hjern on 2025-02-05.

//  For the first screen (location and current weather).

import SwiftUI

struct ContentView: View {
    @State private var locationService = LocationManager()
    @State private var model = WeatherViewModel()
    @State private var currentlocation: String?
    @State private var currentWeather: Weather?
    var body: some View {
            NavigationStack {
                VStack {
                    Text("Weather App")
                        .font(.largeTitle)
                        .padding()
                    //location from tutorial on coursewebbsite
                    Text("Location:")
                    if let city = currentlocation{
                        Text(city)
                    }
                    else {
                        LocationView()
                            .environmentObject(locationService) // Skicka vidare som EnvironmentObject
                    }
                    Text("Current Weather:")
                        .padding()
                    if let weatherCodes = currentWeather?.weatherCode, let firstCode = weatherCodes.first {
                        let description = WeatherViewModel().translateWeatherCode(for: firstCode)  // Skicka endast första koden
                        Text("\(description)")
                    }
                    if let temperature2MMax = currentWeather?.temperature2MMax, let firstTemperatureMax = temperature2MMax.first{
                        if let temperature2MMin = currentWeather?.temperature2MMin, let firstTemperatureMin = temperature2MMin.first {
                        Text("Temperature between: \(String(format: "%.2f", firstTemperatureMax))°C (- \(String(format: "%.2f", firstTemperatureMin)))°C")
                    }
                    }


                    NavigationLink("View more", destination: ForcastView())
                        .padding()
                        .buttonStyle(.bordered)
                }
                .padding()
            }
            .task {
                if let location = locationService.location{
                    let current = await locationService.getCurrentLocation(location)
                    currentlocation = current
                }
                if let weather = await model.loadWeather(){
                    currentWeather = weather
                }
            }
        }
    
}




#Preview {
    ContentView()
}
