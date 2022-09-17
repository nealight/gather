//
//  SignInView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import Foundation
import SwiftUI


struct SignInView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State private var loggedIn = false
    private var title: String
    
    @Environment(\.colorScheme) private var colorScheme
    
    init(title: String = "Welcome Back!") {
        self.title = title
    }
    
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
            VStack {
                Text(self.title)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .padding(.bottom, 20)
                
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
                
                Button(action: {
                    loggedIn = true
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(.blue)
                        .cornerRadius(15.0)
                }
                    .fullScreenCover(isPresented: $loggedIn, content: {MeetupView()})
                
                Spacer()
            }.padding()
        
            
        }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
