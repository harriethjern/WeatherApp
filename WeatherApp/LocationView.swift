//  LocationView.swift
//  WeatherApp
//
//  Created by Harriet Hjern on 2025-02-06.
//

import SwiftUI
import CoreLocationUI

struct LocationView: View {
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            Text("Share your location to get weather")
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
        }
        .padding()
    }
}

#Preview{
    LocationView()
}
