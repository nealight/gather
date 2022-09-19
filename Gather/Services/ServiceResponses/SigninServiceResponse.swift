//
//  SigninServiceResponse.swift
//  Gather
//
//  Created by Yi Xu on 9/18/22.
//

import Foundation

struct SigninServiceResponseModel: Codable {
    var message: String
}

protocol SigninServiceResponseProtocol {
    var message: Published<SigninServiceResponseModel>.Publisher { get }
}
