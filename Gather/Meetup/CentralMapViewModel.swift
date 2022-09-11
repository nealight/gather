//
//  GatherMapViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import Foundation
import CoreLocation

class CentralMapViewModel: ObservableObject {
    var locationManager = CLLocationManager()
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
}
