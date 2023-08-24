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
    
    @Published var locations: Set<ActiveUser> = []
    @Published var updateHappened = false

    let locationManager: CLLocationManager
    private var cancellableSet: Set<AnyCancellable> = []
    let userService: UserService
    
    init(userService: UserService = DependencyResolver.shared.resolve(type: UserService.self)!) {
        // For testing
        self.userService = userService
        self.locationManager = self.userService.locationManager
        configureUserUpdates()
    }
    
    func configureUserUpdates() {
        self.userService.$fetchedUsers
            .receive(on: DispatchQueue.main)
            .sink { users in
            for user in users {
                let userAvatarURL: URL?
                if let profile_avatar = user.profile_avatar {
                    userAvatarURL = URL(string: profile_avatar)
                } else {
                    userAvatarURL = nil
                }
                
                let newLocation: ActiveUser = (.init(id: user.user_name,coordinates: .init(latitude: .init(floatLiteral: user.my_y_coordinate), longitude: .init(floatLiteral: user.my_x_coordinate)), image: ProfileSnapshotView(name: user.user_name, description: user.description ?? defaultProfileDescription, imageURL: userAvatarURL, profileDetailShowable: true)))
                self.locations.update(with: newLocation)
            }
        }.store(in: &cancellableSet)
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
        updateHappened = !updateHappened
    }
    
}
