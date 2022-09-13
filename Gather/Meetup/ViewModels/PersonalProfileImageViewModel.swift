//
//  PersonalProfileImageViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import Foundation
import SwiftUI
import Combine

class PersonalProfileImageViewModel: ObservableObject {
    @Published var profileImage: Image = Image("sample_profile")
    
    private var cancellableSet: Set<AnyCancellable> = []
    
<<<<<<< HEAD
    private var profileImageService: PersonalProfileImageServiceProtocol = ProfileImageService.shared
=======
    private var profileImageService: ProfileImageServiceProtocol = ProfileImageService.shared
>>>>>>> aa1d7b5a00b066d40a6774c8399a8ac4839afd91
    
    init() {
        profileImageService.personalProfileImageDataPublisher.sink { data in
            guard let data = data else {
                return
            }
            guard let uiImage = UIImage(data: data) else {
                return
            }
            self.profileImage = Image(uiImage: uiImage)
        }.store(in: &cancellableSet)
    }
    
    func updateProfileImage(data: Data) {
        print("Start updating image to cloud server")
        profileImageService.uploadImage(imageRawData: data)
    }
    
}
