//
//  MeetupView.swift
//  Gather
//
//  Created by Yi Xu on 9/11/22.
//

import SwiftUI


struct MeetupView: View {
    @State private var showPersonalProfile = false
    var imageURL: URL? {
        if let imageURL = DependencyResolver.shared.resolve(type: UserService.self).downloadImageURL {
            return URL(string: imageURL)
        } else {
            return nil
        }
    }
    @StateObject private var viewModel = MeetupViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(DependencyResolver.shared.resolve(type: UserService.self).getUsername())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                ProfileSnapshotView(name: "", description: "", imageURL: imageURL, profileDetailShowable: false, content: self.$viewModel.personalProfileViewModel.profileImage.wrappedValue)
                    .frame(width: 50, height: 50, alignment: .trailing)
                    .fullScreenCover(isPresented: $showPersonalProfile, onDismiss: {
                        self.viewModel.reloadView()
                    }, content: {
                        PersonalProfileView(personalProfileImageViewModel: self.viewModel.personalProfileViewModel)
                    })
                    .onTapGesture {
                        NSLog("tapped on own personal profile")
                        showPersonalProfile = true
                    }

            }.padding()
            CentralMapView(location: viewModel.locations)
            Spacer()
        }
    }
}

struct MeetupView_Previews: PreviewProvider {
    static var previews: some View {
        MeetupView()
    }
}
