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
                profileImageView.padding()
                Spacer()
                
            }.navigationBarTitle(name, displayMode: .automatic)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "John Appleseed", profileImageView: .init(image: Image("sample_profile")))
    }
}
