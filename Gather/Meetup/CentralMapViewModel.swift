//
//  GatherMapViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI
import Combine

class CentralMapViewModel: ObservableObject {
    var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 42.4534,
                        longitude: -76.4735),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.03,
                        longitudeDelta: 0.03)
                    )
    

    let userService: UserService
    let locationManager: CLLocationManager
    
    init(userService: UserService = DependencyResolver.shared.resolve(type: UserService.self)) {
        // For testing
        self.userService = userService
        self.locationManager = self.userService.locationManager
    }
    
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            updateUserLocation()
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways:
            updateUserLocation()
        case .authorizedWhenInUse:
            updateUserLocation()
        @unknown default:
            break
        }
    }
    
    private func updateUserLocation() {
        let myLocation = locationManager.location
        
        guard let myLocation = myLocation else {
            return
        }

        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: myLocation.coordinate.latitude,
                longitude: myLocation.coordinate.longitude),
            span: MKCoordinateSpan(
                latitudeDelta: 0.03,
                longitudeDelta: 0.03)
            )
        self.objectWillChange.send()
    }
    
}
