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
    func uploadImage(imageRawData: Data)
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { get }
}

class ProfileImageService: ObservableObject, ProfileImageServiceProtocol {
    
    @Published var personalProfileImageData: Data?
    static let shared: ProfileImageServiceProtocol = ProfileImageService()
    
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { $personalProfileImageData }
    
    func uploadImage(imageRawData: Data) {
        personalProfileImageData = imageRawData
    }
    
    
}
