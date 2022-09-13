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
    @StateObject private var personalProfileImageViewModel = PersonalProfileImageViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileImageView(image: $personalProfileImageViewModel.profileImage.wrappedValue)
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
                
            }.navigationBarTitle("John Appleseed", displayMode: .automatic)
        }
    }
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView()
    }
}
