//
//  ProfileImageView.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import SwiftUI

struct ProfileImageView: View {
    let imageURL: URL?
    let content: Image?
    
    init(imageURL: URL?, content: Image? = nil) {
        self.imageURL = imageURL
        self.content = content
    }
    
    var body: some View {
        if let content = content {
            content.resizable()
                .scaledToFit()
                .clipShape(Circle())
        } else {
            AsyncImage(
                url: imageURL,
                content:
                    { image in
                        image.resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                ,
                placeholder: {
                    ProgressView()
                }
            )
        }
        
    }
}


struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(imageURL: nil, content: nil)
    }
}
