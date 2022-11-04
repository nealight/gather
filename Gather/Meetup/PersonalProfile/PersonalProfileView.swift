//
//  PersonalProfileView.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import SwiftUI
import PhotosUI

struct PersonalProfileView: View {
    @State public var selectedItem: PhotosPickerItem? = nil
    @ObservedObject private var personalProfileImageViewModel: PersonalProfileImageViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(personalProfileImageViewModel: PersonalProfileImageViewModel) {
        self.personalProfileImageViewModel = personalProfileImageViewModel
    }
    
    var imageURL: URL? {
        if let imageURL = UserService.shared.downloadImageURL {
            return URL(string: imageURL)
        } else {
            return nil
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileImageView(imageURL: imageURL, content: $personalProfileImageViewModel.profileImage.wrappedValue)
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding()
                
                PhotosPicker(
                    selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Label("Select a photo", systemImage: "photo")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.blue)
                                    .cornerRadius(15.0)
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        personalProfileImageViewModel.updateProfileImage(data: data)
                                    }
                                }
                            }
                
                Spacer()
                
            }.navigationBarTitle(UserService.shared.getUsername(), displayMode: .automatic)
        }
    }
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView(personalProfileImageViewModel: .init())
    }
}
