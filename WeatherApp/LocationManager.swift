//  LocationManager.swift
//  WeatherApp
//
//  Created by Harriet Hjern on 2025-02-05.
//
//location logic from coursewebbsite tutorial + some help from classmate
import Foundation
import CoreLocation
import Observation
import Combine

@Observable
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    var location: CLLocation?
    var address: CLPlacemark?
    var city: String?
    
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    
    func requestLocation() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }
    }
    
    func reverseGeocodeLocation(_ location: CLLocation) {
        Task {
            let placemarks = try? await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks?.last{
                address = placemark
                
                if let city = placemark.locality{
                    print("City: \(city)")
                }
            }
        }
    }
        
        func getCurrentLocation(_ location: CLLocation) async -> String {
            do {
                let placemarks = try? await geocoder.reverseGeocodeLocation(location)
                if let placemark = placemarks?.last {
                    address = placemark
                    if let city = placemark.locality {
                        return city
                    }
                }
            }
            return "error"
        }
        
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if locationManager.authorizationStatus != .denied{
                locationManager.requestLocation()
            }
        }
        
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        if let lastLocation = location {
            reverseGeocodeLocation(lastLocation)  // Uppdatera platsinformation
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error.localizedDescription)
    }

    
}
