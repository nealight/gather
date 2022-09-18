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
    
    private var cancellableSet: Set<AnyCancellable> = []
    var token: String?
    
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func registerAccount(usernameText: String, passwordText: String) -> AnyPublisher<DataResponse<SignupResponseModel, NetworkError>, Never> {
        
        let parameters: [String: String] = [
            "user_name": usernameText,
            "password": passwordText
        ]
        
        let url = networkClient.buildURL(uri: "api/auth/signup")
        
        return AF.request(url, method: .post, parameters: parameters)
                    .validate()
                    .publishDecodable(type: SignupResponseModel.self)
                    .map { response in
                        response.mapError { error in
                            let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                            return NetworkError(initialError: error, backendError: backendError)
                        }
                    }
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
    }
    
    func signinAccount(usernameText: String, passwordText: String) -> AnyPublisher<DataResponse<SigninResponseModel, NetworkError>, Never> {
        let result = self._signinAccount(usernameText: usernameText, passwordText: passwordText)
        result.sink { (dataResponse) in
            if dataResponse.error == nil {
                self.token = dataResponse.value?.token
            }
        }.store(in: &cancellableSet)
        return result
    }
    
    private func _signinAccount(usernameText: String, passwordText: String) -> AnyPublisher<DataResponse<SigninResponseModel, NetworkError>, Never> {
        let parameters: [String: String] = [
            "user_name": usernameText,
            "password": passwordText
        ]
        
        let url = networkClient.buildURL(uri: "api/auth/signin")
        
        return AF.request(url, method: .post, parameters: parameters)
                    .validate()
                    .publishDecodable(type: SigninResponseModel.self)
                    .map { response in
                        response.mapError { error in
                            let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                            return NetworkError(initialError: error, backendError: backendError)
                        }
                    }
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
    }
}
