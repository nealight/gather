//
//  ProfileImageView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI

struct ProfileSnapshotView: View {
    let name: String
    let image: Image
    let profileDetailShowable: Bool
    @State private var showProfile = false
    
    
    var body: some View {
        if profileDetailShowable {
            ProfileImageView(image: image)
                .sheet(isPresented: $showProfile, content: {
                    ProfileView(name: name,
                                profileImageView: .init(image: image))
                })
                .onTapGesture {
                    showProfile = true
                }
        } else {
            ProfileImageView(image: image)
                .sheet(isPresented: $showProfile, content: {
                    ProfileView(name: name,
                                profileImageView: .init(image: image))
                })
        }
    }
        
}

struct ProfileSnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSnapshotView(name: "John Appleseed", image: Image("sample_profile"), profileDetailShowable: true)
    }
}

