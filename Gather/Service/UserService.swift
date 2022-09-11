//
//  UserService.swift
//  Gather
//
//  Created by Yi Xu on 9/10/22.
//

import Foundation
import Alamofire

class UserService {
    static let shared = UserService()
    
    func registerAccount(usernameText: String, passwordText: String) {
        
        let parameters: [String: String] = [
            "username": usernameText,
            "password": passwordText
        ]
        
        NetworkClient.shared.session.request(NetworkClient.shared.buildURL(uri: "api/auth/signup"), method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {response in
                debugPrint(response)
        })
    }
}
