//
//  ProfileImageService.swift
//  Gather
//
//  Created by Yi Xu on 9/13/22.
//

import Foundation
import Combine
import Alamofire


protocol PersonalProfileImageServiceProtocol: ProfileImageServiceProtocol {
    func uploadImage(imageRawData: Data)
}

class PersonalProfileImageService: ObservableObject, PersonalProfileImageServiceProtocol {
    @Published var personalProfileImageData: Data?
    static let shared: PersonalProfileImageServiceProtocol = PersonalProfileImageService()
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { $personalProfileImageData }
    
    func uploadImage(imageRawData: Data) {
        personalProfileImageData = imageRawData
    }
}
