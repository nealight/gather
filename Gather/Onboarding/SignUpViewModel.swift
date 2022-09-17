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
    private var cancellableSet: Set<AnyCancellable> = []
    let userService: UserService
    
    init(userService: UserService = UserService.shared) {
        self.userService = userService
    }
    
    func signUpUser(username: String, password: String) {
        userService.registerAccount(usernameText: username, passwordText: password)
            .sink { (dataResponse) in
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
            .store(in: &cancellableSet)
    }
}
