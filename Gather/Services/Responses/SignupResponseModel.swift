//
//  SignupResponseModel.swift
//  Gather
//
//  Created by Yi Xu on 9/16/22.
//

import Foundation

struct SignupResponseModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    var message: String
}
