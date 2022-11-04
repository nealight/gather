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
    let content: Image?
    
    init(name: String, imageURL: URL?, profileDetailShowable: Bool, content: Image? = nil) {
        self.name = name
        self.imageURL = imageURL
        self.profileDetailShowable = profileDetailShowable
        self.content = content
    }
    
    
    var body: some View {
        if profileDetailShowable {
            ProfileImageView(imageURL: imageURL, content: content)
                .sheet(isPresented: $showProfile, content: {
                    ProfileView(name: name,
                                profileImageView: .init(imageURL: imageURL, content: content))
                })
                .onTapGesture {
                    showProfile = true
                }
        } else {
            ProfileImageView(imageURL: imageURL, content: content)
                .sheet(isPresented: $showProfile, content: {
                    ProfileView(name: name,
                                profileImageView: .init(imageURL: imageURL, content: content))
                })
        }
    }
        
}

struct ProfileSnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSnapshotView(name: "John Appleseed", imageURL: nil, profileDetailShowable: true)
    }
}

