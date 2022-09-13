//
//  ProfileImageService.swift
//  Gather
//
//  Created by Yi Xu on 9/13/22.
//

import Foundation
import Combine
import Alamofire

<<<<<<< HEAD
protocol ProfileImageServiceProtocol {
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { get }
}

protocol PersonalProfileImageServiceProtocol: ProfileImageServiceProtocol {
    func uploadImage(imageRawData: Data)
}

class ProfileImageService: ObservableObject, PersonalProfileImageServiceProtocol {
    
    @Published var personalProfileImageData: Data?
    static let shared: PersonalProfileImageServiceProtocol = ProfileImageService()
=======

protocol ProfileImageServiceProtocol {
    func uploadImage(imageRawData: Data)
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { get }
}

class ProfileImageService: ObservableObject, ProfileImageServiceProtocol {
    
    @Published var personalProfileImageData: Data?
    static let shared: ProfileImageServiceProtocol = ProfileImageService()
>>>>>>> aa1d7b5a00b066d40a6774c8399a8ac4839afd91
    
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { $personalProfileImageData }
    
    func uploadImage(imageRawData: Data) {
        personalProfileImageData = imageRawData
    }
    
    
}
