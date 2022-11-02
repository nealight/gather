//
//  UserService.swift
//  Gather
//
//  Created by Yi Xu on 9/10/22.
//

import Foundation
import Alamofire
import Combine
import CoreLocation


class UserService {
    static let shared = UserService()
    
    let locationManager = CLLocationManager()
    let networkClient: NetworkClient
    
    private var userName: String?
    public var uploadImageURL: String?
    private let refreshInterval = 10.0
    private let refreshTimer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Published var fetchedUsers: [ActiveUserNetworkModel] = []
    
    private var cancellableSet: Set<AnyCancellable> = []
    var token: String?
    
    init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
        self.refreshTimer = Timer.publish(every: refreshInterval, tolerance: 0.5, on: .main, in: .common).autoconnect()
        configureLocationUpdates()
    }
    
    func getUsername() -> String {
        guard let userName = userName, userName != "" else {
            return "John Appleseed"
        }
        return userName
    }
    
    func configureLocationUpdates() {
        self.refreshTimer.sink { _ in
            Task {
                await self.fetchActiveUsers()
            }
        }.store(in: &cancellableSet)
    }
    
    func registerAccount(usernameText: String, passwordText: String) async -> DataResponse<SignupNetworkResponseModel, AFError> {
        
        let parameters: [String: String] = [
            "user_name": usernameText,
            "password": passwordText
        ]
        
        let url = networkClient.buildURL(uri: "api/auth/signup")
        
        return await AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
            self.userName = value.user_name
            
            Task {
                await self.fetchActiveUsers()
            }
        }
        return SigninServiceResponseModel(message: value.message)
    }
    
    private func _signinAccount(usernameText: String, passwordText: String) async -> DataResponse<SigninNetworkResponseModel, AFError> {
        let parameters: [String: String] = [
            "user_name": usernameText,
            "password": passwordText
        ]
        
        let url = networkClient.buildURL(uri: "api/auth/signin")
        
        return await AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                       .validate()
                       .serializingDecodable(SigninNetworkResponseModel.self)
                       .response
    }
    
    func fetchActiveUsers() async {
        guard let response = await self._fetchActiveUsers() else {
            return
        }
        guard let users = response.value else {
            return
        }
        
        fetchedUsers = users.activeUsers.filter({ $0.user_name != self.userName })
//        for user in users.activeUsers {
//            activeUsers.append(.init(coordinates: .init(latitude: .init(floatLiteral: user.x_coordinate), longitude: .init(floatLiteral: user.y_coordinate))))
//        }
        
    }
    
    private func _fetchActiveUsers() async -> DataResponse<ActiveUserQueryNetworkReponseModel, AFError>? {
        guard let token = token else {
            return nil
        }
        
        let myLocation = locationManager.location
        
        guard let myLocation = myLocation else {
            return nil
        }
        
        let parameters: [String: Any] = [
            "token": token,
            "my_x_coordinate": myLocation.coordinate.longitude,
            "my_y_coordinate": myLocation.coordinate.latitude
        ]
        
        let url = networkClient.buildURL(uri: "api/map/update")
        
        return await AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                       .validate()
                       .serializingDecodable(ActiveUserQueryNetworkReponseModel.self)
                       .response
    }
    
}
