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

