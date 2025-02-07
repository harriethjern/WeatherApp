//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Harriet Hjern on 2025-02-05.

//  Handles API calls and data management.

import Foundation

//Taken from course powerpoint https://play.ju.se/media/iOS+Development+Lecture+03+-+WorkshopA+Loading+Data/0_7f68ahfx
@Observable
class WeatherViewModel {
    private let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=Europe%2FBerlin"
    
    private(set) var isLoading = false
    private(set) var weather: Weather?
    
    init() {
        
    }
    
    func loadWeather() async -> Weather?{
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        if let data = try? await URLSession.shared.data(from: url){
            print(String(data: data.0, encoding: .utf8))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                let result = try decoder.decode(WeatherSet.self, from: data.0)
                print(result)
                weather = result.daily
                return weather
            } catch {
                print (error)
            }
        }
        return nil

    }
    
    //func translateWeatherCode from chatGPT https://chatgpt.com/c/67a34edb-5f68-800b-b67e-c34d59886814 (link also inclued some errorhandling)
    func translateWeatherCode(for code: Int) -> String {
        switch code {
        case 0:
            return "Clear sky"
        case 1,2,3:
            return "Mainly clear, partly cloudy, and overcast"
            
        case 45, 48:
            return "Fog and depositing rime fog"
        case 51, 53, 55:
            return "Drizzle: Light, moderate, and dense intensity"
        case 71, 73, 75:
            return "Snow fall: Slight, moderate, and heavy intensity"
        default:
            return "Unknown"
        }
    }

}
