//
//  Weather.swift
//  WeatherApp
//
//  Created by Harriet Hjern on 2025-02-05.
//

import Foundation

struct Weather: Decodable{
    let time : [String]
    let weatherCode: [Int]
    let temperature2MMax: [Float]
    let temperature2MMin: [Float]
}
