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
    
    
    var body: some View {
        if profileDetailShowable {
            ProfileImageView(imageURL: imageURL)
                .sheet(isPresented: $showProfile, content: {
                    ProfileView(name: name,
                                profileImageView: .init(imageURL: imageURL))
                })
                .onTapGesture {
                    showProfile = true
                }
        } else {
            ProfileImageView(imageURL: imageURL)
                .sheet(isPresented: $showProfile, content: {
                    ProfileView(name: name,
                                profileImageView: .init(imageURL: imageURL))
                })
        }
    }
        
}

struct ProfileSnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSnapshotView(name: "John Appleseed", imageURL: nil, profileDetailShowable: true)
    }
}

