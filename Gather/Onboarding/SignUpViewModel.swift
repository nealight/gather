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
    
    init(userService: UserService = UserService.shared) {
        self.userService = userService
    }
    
    @MainActor
    func signUpUser(username: String, password: String) {
        Task {
            let dataResponse = await userService.registerAccount(usernameText: username, passwordText: password)
            
            if dataResponse.error != nil {
                self.signUpError = .error
            } else {
                let message = dataResponse.value?.message
                if message == "ok" {
                    self.enterLogin = true
                } else if message == "duplicate user" {
                    self.signUpError = .duplicate
                }
            }
        }
    }
}
