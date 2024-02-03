//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Ahmed Fathi on 26/01/2024.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime: String?
    @Published var dropOff: String? 
    
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragmant: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragmant
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    //MARK: - Life cycle
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragmant
    }
    //MARK: - Helpers
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            
        }
        
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    func comuteRidePrice(forType type: RideType) -> Double  {
        
        guard let coordinate = selectedUberLocation?.coordinate else { return 0.0 }
        guard let userCoordinate  = self.userLocation else{ return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        
        // it calculate the distance between the userLocation and his destination.
        let tripDistanceInMetters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMetters)
        
    }
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
        let userPlaceMark = MKPlacemark(coordinate: userLocation)
        let destPlaceMark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlaceMark)
        request.destination = MKMapItem(placemark: destPlaceMark)
        
        let direction = MKDirections(request: request)
        direction.calculate { response, error in
            if let error = error {
                print("DEBUG: Failed to get directions with error\(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropOffTimes(with expectedTravelTimes: Double) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropOff = formatter.string(from: Date() + expectedTravelTimes)
        
        
    }
    
    
}

//MARK: -  MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
    
    
    
}
