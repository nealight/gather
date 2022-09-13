//
//  PersonalProfileViewModel.swift
//  Gather
//
//  Created by Yi Xu on 9/12/22.
//

import Foundation
import PhotosUI
import SwiftUI

class ProfilePhotoPickerViewModel: ObservableObject {
    @Published public var selectedItem: PhotosPickerItem? = nil
}
