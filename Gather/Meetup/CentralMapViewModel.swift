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

class CentralMapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 42.4534,
                        longitude: -76.4735),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.03,
                        longitudeDelta: 0.03)
                    )

    var locationManager = CLLocationManager()
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            updateRegion()
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways:
            updateRegion()
        case .authorizedWhenInUse:
            updateRegion()
        @unknown default:
            break
        }
    }
    
    private func updateRegion() {
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
    }
    
}
