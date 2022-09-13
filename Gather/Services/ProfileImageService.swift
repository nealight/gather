//
//  ProfileImageService.swift
//  Gather
//
//  Created by Yi Xu on 9/13/22.
//

import Foundation
import Combine
import Alamofire

protocol ProfileImageServiceProtocol {
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { get }
}

protocol PersonalProfileImageServiceProtocol: ProfileImageServiceProtocol {
    func uploadImage(imageRawData: Data)
}

class ProfileImageService: ObservableObject, PersonalProfileImageServiceProtocol {
    
    @Published var personalProfileImageData: Data?
    static let shared: PersonalProfileImageServiceProtocol = ProfileImageService()
    
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { $personalProfileImageData }
    
    func uploadImage(imageRawData: Data) {
        personalProfileImageData = imageRawData
    }
    
    
}
