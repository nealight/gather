//
//  ProfileImageView.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import SwiftUI

struct ProfileImageView: View {
    let image: Image
    var body: some View {
        image.resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
}


struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(image: Image("sample_profile"))
    }
}
