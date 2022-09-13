//
//  PersonalProfileView.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import SwiftUI
import PhotosUI

struct PersonalProfileView: View {
    @StateObject private var profilePhotoPickerViewModel = ProfilePhotoPickerViewModel()
    @StateObject private var personalProfileImageViewModel = PersonalProfileImageViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileImageView(image: $personalProfileImageViewModel.profileImage.wrappedValue).padding()
                
                PhotosPicker(
                    selection: $profilePhotoPickerViewModel.selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Text("Change Profile Photo")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.blue)
                                    .cornerRadius(15.0)
                            }
                            .onChange(of: profilePhotoPickerViewModel.selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        profilePhotoPickerViewModel.selectedImageData = data
                                    }
                                }
                            }
                Spacer()
                
            }.navigationBarTitle("John Appleseed", displayMode: .automatic)
        }
    }
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView()
    }
}
