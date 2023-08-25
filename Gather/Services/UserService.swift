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

let defaultProfileDescription = "This user is a little shy, so they have yet to provide a profile description :>"

class UserService {
    let userServiceQueue = DispatchQueue(label: "UserServiceQueue")
    
    let locationManager = CLLocationManager()
    let networkClient: NetworkClient
    var imageCache: Dictionary<URL?, Data?> = [nil: nil, ]
    let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue())
    
    private var userName: String?
    private var personalDescription: String?
    
    public var uploadImageURL: String?
    public var downloadImageURL: String?
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
    
    func getPersonalDescription() -> String {
        guard let personalDescription = personalDescription else {
            return defaultProfileDescription
        }
        return personalDescription
    }
    
    func configureLocationUpdates() {
        self.refreshTimer.sink { _ in
            Task {
                await self.fetchActiveUsers()
            }
        }.store(in: &cancellableSet)
    }
    
    func registerAccount(usernameText: String, passwordText: String, completionHandler: @escaping (URLDataResponse<SignupNetworkResponseModel>) -> Void){
        
        let parameters: [String: String] = [
            "user_name": usernameText,
            "password": passwordText
        ]
        let queryItems: [URLQueryItem] = parameters.map() {key, value in  URLQueryItem(name: key, value: value)
        }
        
        var url = URL(string: networkClient.buildURL(uri: "api/auth/signup"))!
        url.append(queryItems: queryItems)
        let request = try! URLRequest(url: url, method: .post)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(URLDataResponse<SignupNetworkResponseModel>(error: error, value: nil))
                }
            }
            do {
                let result = try JSONDecoder().decode(SignupNetworkResponseModel.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(URLDataResponse<SignupNetworkResponseModel>(error: nil, value: result))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler(URLDataResponse<SignupNetworkResponseModel>(error: error, value: nil))
                }
            }
            
        }
        task.resume()
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
            self.personalDescription = value.description
            self.downloadImageURL = value.downloadImageURL
            self.uploadImageURL = value.uploadImageURL
            
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
        
        userServiceQueue.async {
            self.fetchedUsers = users.activeUsers.filter({ $0.user_name != self.userName })
        }
        
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
    
    func updatePersonalProfileDescription(description: String) {
        guard let token = token else {
            return
        }
        let parameters: [String: Any] = [
            "token": token,
            "description": description,
        ]
        
        let url = networkClient.buildURL(uri: "api/profile/updatePersonalDescription")
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: {_ in
            self.personalDescription = description
        })
        
    }
    
    func downloadDataFromURL(url: URL?, completionHandler: @escaping (Data?) -> ()) {
        if let cachedData = imageCache[url] {
            completionHandler(cachedData)
            return
        }
        
        let request = URLRequest(url: url!)
        let task = urlSession.dataTask(with: request) { [url] (data, response, error) in
            if let error = error, data == nil {
                NSLog(error.localizedDescription)
                return
            }
            self.userServiceQueue.async {
                self.imageCache[url!] = data!
            }
            completionHandler(data!)
        }
        task.resume()
    }
}
