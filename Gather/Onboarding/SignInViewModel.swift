//
//  SignInViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/18/22.
//

import Combine
import Foundation

enum SignInError: Identifiable {
    case userNotFound
    case passwordIncorrect
    case error
    
    var id: String {
        switch self {
        case .userNotFound:
            return "userNotFound"
        case .passwordIncorrect:
            return "passwordIncorrect"
        case .error:
            return "error"
        }
    }
}

class SignInViewModel: ObservableObject {
    @Published var signInError: SignInError?
    @Published var signInSuccess: Bool = false
    private var cancellableSet: Set<AnyCancellable> = []
    let userService: UserService
    
    init(userService: UserService = UserService.shared) {
        self.userService = userService
    }
    
    func signInUser(username: String, password: String) {
        userService.signinAccount(usernameText: username, passwordText: password)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.signInError = .error
                } else {
                    let message = dataResponse.value?.message
                    if message == "ok" {
                        self.signInSuccess = true
                    } else if message == "user not found" {
                        self.signInError = .userNotFound
                    } else if message == "password incorrect" {
                        self.signInError = .passwordIncorrect
                    }
                }
            }
            .store(in: &cancellableSet)
    }
}
