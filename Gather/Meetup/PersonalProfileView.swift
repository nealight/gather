//
//  PersonalProfileView.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import SwiftUI
import PhotosUI

struct PersonalProfileView: View {
    @StateObject private var personalProfileViewModel = PersonalProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileImageView(image: .init("sample_profile")).padding()
                
                PhotosPicker(
                    selection: $personalProfileViewModel.selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Text("Change Profile Photo")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.blue)
                                    .cornerRadius(15.0)
                            }
                            .onChange(of: personalProfileViewModel.selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        personalProfileViewModel.selectedImageData = data
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
