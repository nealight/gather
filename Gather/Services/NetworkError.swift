//
//  ServiceError.swift
//  Gather
//
//  Created by Yi Xu on 9/13/22.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
