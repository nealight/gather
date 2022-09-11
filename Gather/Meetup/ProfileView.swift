//
//  ProfileView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                ProfileImageView().padding()
                Spacer()
                
            }.navigationBarTitle("John Appleseed", displayMode: .automatic)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
