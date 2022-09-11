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
    @State private var showProfile = false
    
    var body: some View {
        ProfileImageView(image: image)
            .sheet(isPresented: $showProfile, content: {ProfileView(name: name,
                                                                    profileImageView: .init(image: image))})
            .onTapGesture {
                showProfile = true
            }
    }
        
}

struct ProfileImageView: View {
    let image: Image
    var body: some View {
        image.resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
}
