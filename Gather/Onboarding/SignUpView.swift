//
//  Gather
//
//  Created by Yi Xu on 9/10/22.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct SignUpView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    @StateObject var signUpViewModel = SignUpViewModel()
    
    @Environment(\.colorScheme) private var colorScheme
    
    public var textFieldColor: Color {
        switch colorScheme {
            case .light:
            return lightGreyColor
            case .dark:
            return lightGreyColor.opacity(0.2)
            @unknown default:
            return lightGreyColor
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                TextField("Username", text: $username)
                                .padding()
                                .background(textFieldColor)
                                .cornerRadius(10.0)
                                .padding(.bottom, 20)
                                
                SecureField("Password", text: $password)
                    .padding()
                    .background(textFieldColor)
                    .cornerRadius(10.0)
                    .padding(.bottom, 20)
                
                NavigationLink(destination: SignInView(), isActive: $signUpViewModel.enterLogin) {
                    Button(action: {
                        signUpViewModel.signUpUser(username: username, password: password)
                    }) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(.blue)
                            .cornerRadius(15.0)
                    }
                }
                .navigationTitle("Join Gather")
                .alert(item: $signUpViewModel.signUpError) { value in
                    switch value {
                        
                    case .duplicate:
                        return Alert(title: Text("Duplicate User"))
                    case .error:
                        return Alert(title: Text("Server Error"))
                    }
                }
                NavigationLink {
                    SignInView()
                } label: {
                    Button(action: {})
                    {
                        Text("Sign In Instead")
                                    .font(.headline)
                                    .padding()
                    }
                }
                .navigationTitle("Join Gather")
                
                Spacer()
                
            }.padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
