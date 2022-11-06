//
//  ProfileImageService.swift
//  Gather
//
//  Created by Yi Xu on 9/13/22.
//

import Foundation
import Combine
import Alamofire
import SwiftUI


protocol PersonalProfileImageServiceProtocol: ProfileImageServiceProtocol {
    func uploadImage(imageRawData: Data)
}

class PersonalProfileImageService: ObservableObject, PersonalProfileImageServiceProtocol {
    @Published var personalProfileImageData: Data?
    static let shared: PersonalProfileImageServiceProtocol = PersonalProfileImageService()
    static let networkClient = NetworkClient.shared
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { $personalProfileImageData }
    
    func uploadImage(imageRawData: Data) {
        personalProfileImageData = imageRawData
        uploadImageWithLink(imageRawData: imageRawData)
    }
    
    private func uploadImageWithLink(imageRawData: Data?) {
        
        guard let putURL = UserService.shared.uploadImageURL, let imgData = imageRawData else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-ms-blob-type": "BlockBlob",
        ]
        
        AF.upload(imgData, to: URL(string: putURL)!, method: .put, headers: headers).responseData(completionHandler: {response in
            debugPrint(response)
        })
        
    }
}
