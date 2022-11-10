//
//  ProfileImageView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI

struct ProfileSnapshotView: View {
    let name: String
    let imageURL: URL?
    let profileDetailShowable: Bool
    @State private var showProfile = false
    let profileImageView: ProfileImageView
    
    init(name: String, imageURL: URL?, profileDetailShowable: Bool, content: Image? = nil) {
        self.name = name
        self.imageURL = imageURL
        self.profileDetailShowable = profileDetailShowable
        self.profileImageView = ProfileImageView(imageURL: imageURL, content: content)
    }
    
    
    
    var body: some View {
        if profileDetailShowable {
            ProfileImageView(imageURL: imageURL, placeholder: Image("default_avatar").resizable())
                .sheet(isPresented: $showProfile, content: {
                    ProfileView(name: name, description: "Description",
                                profileImageView: profileImageView)
                })
                .onTapGesture {
                    showProfile = true
                }
        } else {
            profileImageView
                .sheet(isPresented: $showProfile, content: {
                    ProfileView(name: name, description: "Description",
                                profileImageView: profileImageView)
                })
        }
    }
        
}

struct ProfileSnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSnapshotView(name: "John Appleseed", imageURL: nil, profileDetailShowable: true)
    }
}

