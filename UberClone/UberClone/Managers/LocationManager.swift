//
//  LocationManager.swift
//  UberClone
//
//  Created by Ahmed Fathi on 25/01/2024.
//

import CoreLocation

// this is the requset from user to access to his location. (also we should go info.pilst and add in bundle name 'location when in useage description')

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
   static  let shared = LocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}


extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
        
        
    }
    
}
