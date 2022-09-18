//
//  SignInViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/18/22.
//

import Combine
import Foundation

class SignInViewModel: ObservableObject {
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
                   
                } else {
                    let message = dataResponse.value?.message
                    if message == "ok" {
                        self.signInSuccess = true
                    } else if message == "" {
                        
                    }
                }
            }
            .store(in: &cancellableSet)
    }
}
