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
    
    var body: some View {
            VStack {
                Text("Welcome back!")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .padding(.bottom, 20)
                
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
                
                Button("Sign In", action: {
                    loggedIn = true
                })
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(.blue)
                    .cornerRadius(15.0)
                    .fullScreenCover(isPresented: $loggedIn, content: {MeetupView()})
                
            }.padding()
        
        }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
