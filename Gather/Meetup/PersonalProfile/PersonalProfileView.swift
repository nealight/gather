//
//  PersonalProfileView.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import SwiftUI
import PhotosUI

struct PersonalProfileView: View {
    @State private var description: String = DependencyResolver.shared.resolve(type: UserService.self).getPersonalDescription()

    @State public var selectedItem: PhotosPickerItem? = nil
    @ObservedObject private var personalProfileImageViewModel: PersonalProfileImageViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var descriptionIsFocused: Bool
    
    
    public var textFieldColor: Color {
        switch colorScheme {
            case .light:
            return lightGreyColor
            case .dark:
            return lightGreyColor.opacity(0.2)
            @unknown default:
            return lightGreyColor
        }
    }
    
    
    init(personalProfileImageViewModel: PersonalProfileImageViewModel) {
        self.personalProfileImageViewModel = personalProfileImageViewModel
    }
    
    var imageURL: URL? {
        if let imageURL = DependencyResolver.shared.resolve(type: UserService.self).downloadImageURL {
            return URL(string: imageURL)
        } else {
            return nil
        }
    }
    @Namespace var descriptionTextEditorAnchor
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView {
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
                        }.padding(.bottom, 20)
                    
                    Spacer()
                    TextField(
                        "Description of your Profile",
                        text: $description,
                        axis: .vertical
                    )
                    .focused($descriptionIsFocused)
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 4).delay(1)) {
                            proxy.scrollTo(descriptionTextEditorAnchor, anchor: .center)
                        }
                        
                    }
                    .lineLimit(3)
                    .onSubmit {
                        print(description)
                    }
                    .padding()
                    .background(textFieldColor)
                    .cornerRadius(10.0)
                    .padding()
                    .id(descriptionTextEditorAnchor)
                    
                    
                }.navigationBarTitle(DependencyResolver.shared.resolve(type: UserService.self).getUsername(), displayMode: .automatic)
                    .navigationBarItems(
                        trailing:
                            Button(action : {
                                DependencyResolver.shared.resolve(type: UserService.self).updatePersonalProfileDescription(description: description)
                                self.dismiss()
                            }) {
                            Text("Save")
                        })
            }.onTapGesture {
                descriptionIsFocused = false
            }
        }
    }
}

struct PersonalProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalProfileView(personalProfileImageViewModel: .init())
    }
}
