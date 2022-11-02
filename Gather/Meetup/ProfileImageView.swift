//
//  ProfileImageView.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import SwiftUI

struct ProfileImageView: View {
    let imageURL: URL?
    var body: some View {
        AsyncImage(
            url: imageURL,
            content: { image in
                image.resizable()
                     .scaledToFit()
                     .clipShape(Circle())
            },
            placeholder: {
                Image("default_avatar").resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
        )
        
    }
}


struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(imageURL: nil)
    }
}
