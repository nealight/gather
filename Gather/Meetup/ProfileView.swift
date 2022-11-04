//
//  ProfileView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI

struct ProfileView: View {
    let name: String
    let profileImageView: ProfileImageView
    var body: some View {
        NavigationView {
            VStack {
                profileImageView.frame(width: 400, height: 400, alignment: .center).padding()
                Spacer()
                
            }.navigationBarTitle(name, displayMode: .automatic)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "John Appleseed", profileImageView: .init(imageURL: nil))
    }
}
