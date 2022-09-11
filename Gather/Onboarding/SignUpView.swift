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
    
    @State var signUpUser = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                                .padding()
                                .background(lightGreyColor)
                                .cornerRadius(5.0)
                                .padding(.bottom, 20)
                                
                SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button(action: {print("Button tapped")}) {
                    Text("Register")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(.blue)
                                .cornerRadius(15.0)
                }
                
                NavigationLink(destination: SignInView(), isActive: $signUpUser) {
                    Button(action: {signUpUser = true}) {
                        Text("Sign In Instead")
                                    .font(.headline)
                                    .padding()
                    }
                }.navigationTitle("Join Gather")
                
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
