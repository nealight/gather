//
//  SigninResponseModel.swift
//  Gather
//
//  Created by Yi Xu on 9/18/22.
//

import Foundation

struct SigninNetworkResponseModel: Codable {
    var message: String
    var user_name: String?
    var description: String?
    var uploadImageURL: String?
    var downloadImageURL: String?
    var token: String?
}
