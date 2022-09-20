//
//  UserService.swift
//  Gather
//
//  Created by Yi Xu on 9/10/22.
//

import Foundation
import Alamofire
import Combine


class UserService {
    static let shared = UserService()
    let networkClient: NetworkClient
    @Published var signInServiceResponse: SigninServiceResponseModel = .init(message: "")
    var signInServiceResponsePublisher: Published<SigninServiceResponseModel>.Publisher { $signInServiceResponse }
        
    private var cancellableSet: Set<AnyCancellable> = []
    var token: String?
    
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func registerAccount(usernameText: String, passwordText: String) async -> DataResponse<SignupNetworkResponseModel, AFError> {
        
        let parameters: [String: String] = [
            "user_name": usernameText,
            "password": passwordText
        ]
        
        let url = networkClient.buildURL(uri: "api/auth/signup")
        
        return await AF.request(url, method: .post, parameters: parameters)
                       .validate()
                       .serializingDecodable(SignupNetworkResponseModel.self)
                       .response
    }
    
    func signinAccount(usernameText: String, passwordText: String) async -> SigninServiceResponseModel {
        let response = await self._signinAccount(usernameText: usernameText, passwordText: passwordText)
    
        guard let value = response.value else {
            return SigninServiceResponseModel(message: "server error")
        }
        self.token = value.token
        return SigninServiceResponseModel(message: value.message)
    }
    
    private func _signinAccount(usernameText: String, passwordText: String) async -> DataResponse<SigninNetworkResponseModel, AFError> {
        let parameters: [String: String] = [
            "user_name": usernameText,
            "password": passwordText
        ]
        
        let url = networkClient.buildURL(uri: "api/auth/signin")
        
        return await AF.request(url, method: .post, parameters: parameters)
                       .validate()
                       .serializingDecodable(SigninNetworkResponseModel.self)
                       .response
    }
}
