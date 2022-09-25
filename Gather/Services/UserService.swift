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
        
        if response.response?.statusCode == 200 {
            // Only store token when status code shows success
            self.token = value.token
        }
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
    
    func fetchActiveUsers() async {
        guard let response = await self._fetchActiveUsers() else {
            return
        }
        debugPrint(response)
        
        
    }
    
    private func _fetchActiveUsers() async -> DataResponse<ActiveUserQueryNetworkReponseModel, AFError>? {
        guard let token = token else {
            return nil
        }
        let parameters: [String: String] = [
            "token": token,
        ]
        
        let url = networkClient.buildURL(uri: "api/map/fetch_all_active_users")
        
        return await AF.request(url, method: .post, parameters: parameters)
                       .validate()
                       .serializingDecodable(ActiveUserQueryNetworkReponseModel.self)
                       .response
    }
}
