//
//  ProfileImageView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        Image("sample_profile")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
}
