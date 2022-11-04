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
    let placeholder: Image?
    
    init(imageURL: URL?, content: Image? = nil, placeholder: Image? = nil) {
        self.imageURL = imageURL
        self.content = content
        self.placeholder = placeholder
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
                    if placeholder != nil {
                        placeholder.scaledToFit()
                    } else {
                        ProgressView().scaledToFit()
                    }
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
