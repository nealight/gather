//
//  SignUpViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/16/22.
//

import Combine
import Foundation

enum SignUpError: Identifiable {
    case duplicate
    case error
    
    var id: String {
        switch self {
        case .duplicate:
            return "duplicate"
        case .error:
            return "error"
        }
    }
}

class SignUpViewModel: ObservableObject {
    @Published var signUpError: SignUpError?
    @Published var enterLogin = false
    let userService: UserService
    
    init(userService: UserService = DependencyResolver.shared.resolve(type: UserService.self)) {
        self.userService = userService
    }
    
    func signUpUser(username: String, password: String) {
        userService.registerAccount(usernameText: username, passwordText: password) { dataResponse in
            if dataResponse.error != nil {
                self.signUpError = .error
            } else {
                let message = dataResponse.getDataModel().message
                if message == "ok" {
                    self.enterLogin = true
                } else if message == "duplicate user" {
                    self.signUpError = .duplicate
                }
            }
        }
    }
}
