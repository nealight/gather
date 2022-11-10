//
//  ProfileView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI

struct ProfileView: View {
    let name: String
    let description: String
    let profileImageView: ProfileImageView
    var body: some View {
        NavigationView {
            VStack {
                profileImageView.frame(width: 300, height: 300, alignment: .center).padding()
                Text(verbatim: description)
                    .font(.system(size: 20, weight: .light, design: .serif))
                    
                Spacer()
                
            }.navigationBarTitle(name, displayMode: .automatic)
                .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "John Appleseed", description: "Description", profileImageView: .init(imageURL: nil))
    }
}
