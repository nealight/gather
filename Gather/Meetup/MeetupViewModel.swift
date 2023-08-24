//
//  MeetupViewModel.swift
//  Gather
//
//  Created by Yi Xu on 11/2/22.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI
import Combine

class MeetupViewModel: ObservableObject {
    public var personalProfileViewModel = PersonalProfileImageViewModel()
    
    func reloadView() {
        objectWillChange.send()
    }
    

    private var cancellableSet: Set<AnyCancellable> = []
    let userService: UserService
    @Published var locations: Set<ActiveUser> = []
    
    init(userService: UserService = DependencyResolver.shared.resolve(type: UserService.self)!) {
        // For testing
        self.userService = userService
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
}
