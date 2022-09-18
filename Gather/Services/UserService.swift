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
    
    func signinAccount(usernameText: String, passwordText: String) -> Published<SigninServiceResponseModel>.Publisher {
        
        let result = self._signinAccount(usernameText: usernameText, passwordText: passwordText)
        result.sink { (dataResponse) in
            guard let value = dataResponse.value else {
                return
            }
            if dataResponse.error == nil {
                self.token = value.token
                self.signInServiceResponse = SigninServiceResponseModel(message: value.message)
            }
        }.store(in: &cancellableSet)
        return self.signInServiceResponsePublisher
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
