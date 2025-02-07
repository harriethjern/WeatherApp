//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Harriet Hjern on 2025-02-05.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager) // Viktigt!

        }
    }
}
