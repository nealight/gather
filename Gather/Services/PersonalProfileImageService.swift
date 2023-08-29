//
//  ProfileImageService.swift
//  Gather
//
//  Created by Yi Xu on 9/13/22.
//

import Foundation
import Combine
import SwiftUI

protocol PersonalProfileImageServiceProtocol: ProfileImageServiceProtocol {
    func uploadImage(imageRawData: Data)
}

class PersonalProfileImageService: ObservableObject, PersonalProfileImageServiceProtocol {
    @Published var personalProfileImageData: Data!
    static let shared: PersonalProfileImageServiceProtocol = PersonalProfileImageService()
    static let networkClient = NetworkClient.shared
    var personalProfileImageDataPublisher: Published<Data?>.Publisher { $personalProfileImageData }
    
    func uploadImage(imageRawData: Data) {
        personalProfileImageData = imageRawData
        uploadImageWithLink(imageRawData: imageRawData)
    }
    
    private func uploadImageWithLink(imageRawData: Data) {
        
        guard let putURL = URL(string: DependencyResolver.shared.resolve(type: UserService.self).uploadImageURL ?? "") else {
            return
        }
        
        let headers = [
            "x-ms-blob-type": "BlockBlob",
        ]
        
        let request = try! URLRequest(url: putURL, method: .put, headers: .init(headers))
        let task = URLSession.shared.uploadTask(with: request, from: imageRawData) { _, _, error in
            if let error = error {
                NSLog(error.localizedDescription)
            }
        }
        task.resume()
        
        
//        AF.upload(imgData, to: URL(string: putURL)!, method: .put, headers: headers).responseData(completionHandler: {response in
//            debugPrint(response)
//        })
        
    }
}
