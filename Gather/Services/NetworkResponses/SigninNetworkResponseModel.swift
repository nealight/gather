//
//  SigninResponseModel.swift
//  Gather
//
//  Created by Yi Xu on 9/18/22.
//

import Foundation

struct SigninNetworkResponseModel: Codable {
    var message: String
    var token: String?
}